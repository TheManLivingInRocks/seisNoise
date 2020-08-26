module seismo_parameters
! yanhuay@princeton.edu

use constants, only: IIN, IOUT,IOUTALL, MAX_STRING_LEN,MAX_FILENAME_LEN,MAX_KERNEL_NUM, &
    MAX_LINES,MAX_MISFIT_TYPE, SIZE_REAL, SIZE_DOUBLE, CUSTOM_REAL,CUSTOM_COMPLEX,&
    LARGE_VAL, SMALL_VAL,PI

implicit none

!----------------------------------------------------------------------
! constants
! number of Gauss-Lobatto-Legendre (GLL) points (i.e., polynomial degree + 1)
INTEGER, PARAMETER :: NGLLX=5
! number of Gauss-Lobatto-Jacobi (GLJ) points in the axial elements (i.e.,
! polynomial degree + 1)
! the code does NOT work if NGLLZ /= NGLLX because it then cannot handle a
! non-structured mesh
! due to non matching polynomial degrees along common edges
INTEGER, PARAMETER :: NGLLZ=5
INTEGER, PARAMETER :: NGLLY=1

!! solver
CHARACTER (LEN=20) :: solver='specfem2D'
CHARACTER (LEN=MAX_STRING_LEN) :: LOCAL_PATH='OUTPUT_FILES'
CHARACTER (LEN=MAX_STRING_LEN) :: IBOOL_NAME='NSPEC_ibool.bin'

!! FORWARD MODELNG INFO
INTEGER, PARAMETER :: NSTEP=4800
REAL(KIND=CUSTOM_REAL), PARAMETER :: deltat=0.06
REAL(KIND=CUSTOM_REAL), PARAMETER :: t0=0.0
REAL(KIND=CUSTOM_REAL), PARAMETER :: f0=0.084
INTEGER, PARAMETER :: NREC=2
INTEGER, PARAMETER :: NSRC=1
CHARACTER (LEN=20) :: seismotype='displacement'

!! PRE-PROCESSING
! wavelet
INTEGER, PARAMETER :: Wscale=0

! bandpass
LOGICAL :: IS_BANDPASS=.false.
REAL(KIND=8), PARAMETER :: Fmin1=50
REAL(KIND=8), PARAMETER :: Fmax1=40
REAL(KIND=8), PARAMETER :: Fmin2=45
REAL(KIND=8), PARAMETER :: Fmax2=30
REAL(KIND=8), PARAMETER :: Fmin3=35
REAL(KIND=8), PARAMETER :: Fmax3=20
REAL(KIND=8), PARAMETER :: Fmin4=25
REAL(KIND=8), PARAMETER :: Fmax4=10
REAL(KIND=8), PARAMETER :: Fmin5=15
REAL(KIND=8), PARAMETER :: Fmax5=10
REAL(KIND=8), PARAMETER :: Fmin6=12
REAL(KIND=8), PARAMETER :: Fmax6=7
REAL(KIND=8), PARAMETER :: Fmin7=8
REAL(KIND=8), PARAMETER :: Fmax7=5

REAL(KIND=8), PARAMETER :: Fmin8=10
REAL(KIND=8), PARAMETER :: Fmax8=5

! the number of bandpass
INTEGER, PARAMETER :: num_filter=4
REAL(KIND=8), PARAMETER :: misfit_value_min=4


REAL(KIND=8), PARAMETER :: Vp1=3.795
REAL(KIND=8), PARAMETER :: Vp2=3.62
REAL(KIND=8), PARAMETER :: Vp3=3.511
REAL(KIND=8), PARAMETER :: Vp4=3.277
REAL(KIND=8), PARAMETER :: Vp5=3.177
REAL(KIND=8), PARAMETER :: Vp6=3.165
REAL(KIND=8), PARAMETER :: Vp7=3.135

REAL(KIND=8), PARAMETER :: mean1=-0.38
REAL(KIND=8), PARAMETER :: mean2=-0.63
REAL(KIND=8), PARAMETER :: mean3=-0.37
REAL(KIND=8), PARAMETER :: mean4=-0.10
REAL(KIND=8), PARAMETER :: mean5=0.080
REAL(KIND=8), PARAMETER :: mean6=0.376
REAL(KIND=8), PARAMETER :: mean7=0.45

REAL(KIND=8), PARAMETER :: std1=0.73
REAL(KIND=8), PARAMETER :: std2=0.62
REAL(KIND=8), PARAMETER :: std3=0.46
REAL(KIND=8), PARAMETER :: std4=0.5
REAL(KIND=8), PARAMETER :: std5=0.572
REAL(KIND=8), PARAMETER :: std6=0.911
REAL(KIND=8), PARAMETER :: std7=0.950

!sigma (estated error)
LOGICAL :: IS_SIGMA=.false.

! misfit_weighting
LOGICAL :: misfit_weighting=.false.





!window
LOGICAL :: TIME_WINDOW=.false.
INTEGER, PARAMETER :: window_type=3
REAL(KIND=CUSTOM_REAL), PARAMETER :: taper_percentage=0.2
CHARACTER (LEN=4) :: taper_type='hann'
REAL(KIND=CUSTOM_REAL), PARAMETER :: min_window_len=1.0/f0
REAL(KIND=CUSTOM_REAL), PARAMETER :: VEL_TOP=3900
REAL(KIND=CUSTOM_REAL), PARAMETER :: VEL_BOT=3100

! window
REAL(KIND=CUSTOM_REAL), PARAMETER :: window_len=3.0/f0
REAL(KIND=CUSTOM_REAL), PARAMETER :: taper_len=1.2/f0
REAL(KIND=CUSTOM_REAL), PARAMETER :: T0_TOP=t0
REAL(KIND=CUSTOM_REAL), PARAMETER :: T0_BOT=T0_TOP+window_len



!! window 
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE  :: win_start, win_end
REAL(KIND=CUSTOM_REAL) ::  tstart, tend
REAL(KIND=CUSTOM_REAL) ::  tstart_ref, tend_ref

! damping
LOGICAL :: DAMPING=.false.
REAL(KIND=CUSTOM_REAL), PARAMETER :: X_decay=1.0
REAL(KIND=CUSTOM_REAL), PARAMETER :: T_decay=1.0
! mute
LOGICAL :: MUTE_NEAR=.false.
REAL(KIND=CUSTOM_REAL), PARAMETER :: offset_near=0
LOGICAL :: MUTE_FAR=.false.
REAL(KIND=CUSTOM_REAL), PARAMETER :: offset_far=0
! event nomralize
LOGICAL :: EVENT_NORMALIZE=.false.
! trace nomralize
LOGICAL :: TRACE_NORMALIZE=.false.

!! measurement type weight 
INTEGER, PARAMETER :: mtype=MAX_MISFIT_TYPE
REAL(KIND=CUSTOM_REAL), DIMENSION(mtype) :: measurement_weight=1

!! DD par
REAL(KIND=CUSTOM_REAL), PARAMETER :: cc_threshold=0.9
REAL(KIND=CUSTOM_REAL), PARAMETER :: DD_min=SMALL_VAL
REAL(KIND=CUSTOM_REAL), PARAMETER :: DD_max=LARGE_VAL

!! OPTIMIZATION
CHARACTER (LEN=2) :: opt_scheme='QN'
INTEGER, PARAMETER :: CGSTEPMAX=10
CHARACTER (LEN=2) :: CG_scheme='PR'
INTEGER, PARAMETER :: BFGS_STEPMAX=10
REAL(KIND=CUSTOM_REAL), PARAMETER :: initial_step_length=0.01
INTEGER, PARAMETER :: max_step=10
REAL(KIND=CUSTOM_REAL), PARAMETER :: min_step_length=0.002
LOGICAL :: backtracking=.true.

!! CONVERGENCE?
INTEGER, PARAMETER :: iter_start=1
INTEGER, PARAMETER :: iter_end=1
REAL(KIND=CUSTOM_REAL), PARAMETER :: misfit_ratio_initial=0.001
REAL(KIND=CUSTOM_REAL), PARAMETER :: misfit_ratio_previous=0.001

!! POST-PROCESSING
LOGICAL :: smooth=.false.
LOGICAL :: MASK_SOURCE=.false.
LOGICAL :: MASK_STATION=.false.
REAL(KIND=CUSTOM_REAL), PARAMETER :: source_radius=0.0
REAL(KIND=CUSTOM_REAL), PARAMETER :: station_radius=0.0
LOGICAL :: precond=.false.
REAL(KIND=CUSTOM_REAL), PARAMETER :: wtr_precond=0.1
!BH
LOGICAL :: Taper_surface=.false.
REAL(KIND=CUSTOM_REAL), PARAMETER :: z_top=100000
REAL(KIND=CUSTOM_REAL), PARAMETER :: z_bot=95000



!! DISPLAY 
LOGICAL :: DISPLAY_DETAILS=.false.
LOGICAL :: DISPLAY_TRACES=.false.


!!!!!!!!!!!!!!!!! gloabl variables !!!!!!!!!!!!!!!!!!!!!!
INTEGER :: myrank,nproc,iproc

!! ADJOINT?
LOGICAL :: compute_adjoint

!! ADJOINT?
LOGICAL :: empire_function=.false.

!! data
INTEGER :: ndata
INTEGER,PARAMETER :: MAX_DATA_NUM=4
INTEGER, DIMENSION(:), ALLOCATABLE :: which_proc_receiver
INTEGER :: nrec_proc  ! trace from a single proc
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs_mute
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs1
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs2
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs3
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs4
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs5
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs6
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs7
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_obs8

REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: win1_obs
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: win2_obs
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: win1_syn
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: win2_syn

REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn_mute
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn1
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn2
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn3
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn4
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn5
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn6
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn7
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_syn8

REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: misfit_deltat

REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj1
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj2
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj3
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj4
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj5
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj6
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj7
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj8

REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD_before
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD1
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD2
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD3
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD4
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD5
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD6
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD7
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_AD8


REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_DD
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_DD1
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_DD2
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:), ALLOCATABLE :: seism_adj_DD3

REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: st_xval,st_yval,st_zval
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: dis_sr
REAL(KIND=CUSTOM_REAL) :: x_source, y_source, z_source
INTEGER(KIND=4) :: r4head(60)
INTEGER(KIND=2) :: header2(2)
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: time
REAL(KIND=CUSTOM_REAL) :: ratio_data_syn=0.01

!! measurement
CHARACTER(LEN=MAX_STRING_LEN) :: measurement_list
CHARACTER(LEN=MAX_STRING_LEN) :: misfit_type_list

!! window 
INTEGER,DIMENSION(:), ALLOCATABLE  :: win_start_save, win_end_save

! event nomralize
REAL(KIND=CUSTOM_REAL) :: event_norm
! trace nomralize
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: trace_norm

!! damping 
REAL(KIND=CUSTOM_REAL) :: lambda_x=1.0/X_decay
REAL(KIND=CUSTOM_REAL) :: lambda_t=1.0/T_decay

!! source-timefunction
LOGICAL :: conv_stf=.false.
CHARACTER (LEN=MAX_FILENAME_LEN) :: stf_file='source.txt'
REAL(KIND=CUSTOM_REAL) :: tshift_stf, integral_stf
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: stf
INTEGER :: stf_len

!! misfit
INTEGER :: num_AD,num_AD1,num_AD2,num_AD3,num_AD4,num_AD5,num_AD6,num_AD7,num_AD8,num_DD
INTEGER, DIMENSION(:,:), ALLOCATABLE :: is_pair
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: misfit_proc
REAL(KIND=CUSTOM_REAL) :: misfit_AD,misfit_DD, misfit, dt_all
REAL(KIND=CUSTOM_REAL) :: misfit_AD1,misfit_DD1, misfit1
REAL(KIND=CUSTOM_REAL) :: misfit_AD2,misfit_DD2, misfit2
REAL(KIND=CUSTOM_REAL) :: misfit_AD3,misfit_DD3, misfit3
REAL(KIND=CUSTOM_REAL) :: misfit_AD4,misfit_DD4, misfit4
REAL(KIND=CUSTOM_REAL) :: misfit_AD5,misfit_DD5, misfit5
REAL(KIND=CUSTOM_REAL) :: misfit_AD6,misfit_DD6, misfit6
REAL(KIND=CUSTOM_REAL) :: misfit_AD7,misfit_DD7, misfit7
REAL(KIND=CUSTOM_REAL) :: misfit_AD8,misfit_DD8, misfit8

!! kernels
INTEGER :: nspec
INTEGER, DIMENSION(:), ALLOCATABLE :: nspec_proc
INTEGER :: nker
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: g_new
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: g_empire
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: p_new

!! models
INTEGER :: nmod
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: m_new
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: m_new_vp
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: m_new_rho

REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: m_delta
REAL(KIND=CUSTOM_REAL), DIMENSION(:), ALLOCATABLE :: m_try

!! linesearch
INTEGER :: is_done, is_cont, is_brak
REAL(KIND=CUSTOM_REAL) :: step_length, next_step_length,optimal_step_length

!! mask source
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:,:,:), ALLOCATABLE :: xstore
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:,:,:), ALLOCATABLE :: ystore
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:,:,:), ALLOCATABLE :: zstore
REAL(KIND=CUSTOM_REAL), DIMENSION(:,:,:,:), ALLOCATABLE :: mask
!----------------------------------------------------------------------

end module seismo_parameters
