!***********************************************************************
!
subroutine writefiles
!
! Write output files in Paraview .vtu format
!
!***********************************************************************
!
  use types
  use parameters
  use title_mod
  use geometry
  use variables
  use statistics
  use sparse_matrix
  use output

  implicit none
!
!***********************************************************************
!
  integer :: output_unit
  ! integer :: i,ijb

  ! Write in a char variable current timestep number and create a folder with this name
  write(timechar,'(i6)') itime

  !+-----------------------------------------------------------------------------+

  call get_unit( output_unit )

  open(unit=output_unit,file='VTK/innerField-'//trim(adjustl(timechar))//'.vtu')


  ! Header
  call vtu_write_XML_header ( output_unit )

  !+-----------------------------------------------------------------------------+

  ! Write fields to VTU file

  call vtu_write_XML_vector_field( output_unit, 'U', u, v, w )


  call vtu_write_XML_scalar_field ( output_unit, 'p', p )


  if( lturb ) then

    call vtu_write_XML_scalar_field ( output_unit, 'mueff', vis )

  endif


  if(solveTKE) then

    call vtu_write_XML_scalar_field ( output_unit, 'k', te )

  endif


  if( solveEpsilon ) then

    call vtu_write_XML_scalar_field ( output_unit, 'epsilon', ed )

  endif


  if( solveOmega ) then

    call vtu_write_XML_scalar_field ( output_unit, 'omega', ed )

  endif      

  !+-----------------------------------------------------------------------------+

  ! Mesh data
  call vtu_write_XML_meshdata ( output_unit )

  close( output_unit )


  ! ! Recirculate output
  ! call get_unit( output_unit )
  ! open(unit=output_unit,file='inlet')
  ! rewind output_unit

  ! do i=1,nout
  !   ijb = iOutletStart+i
  !   write(output_unit,'(5(1x,es11.4))') u(ijb), v(ijb), w(ijb), te(ijb), ed(ijb)
  ! end do

  ! close( output_unit )


end subroutine

