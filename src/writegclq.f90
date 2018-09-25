
! Copyright (C) 2002-2005 J. K. Dewhurst, S. Sharma and C. Ambrosch-Draxl.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

!BOP
! !ROUTINE: writegclq
! !INTERFACE:
subroutine writegclq
! !USES:
use modmain
! !DESCRIPTION:
!   Outputs the volume-averaged integral of $4\pi/q^2$ in the small
!   parallelepiped around each discrete $q$-point to the file {\tt GCLQ.OUT}.
!   These represent the regularised Coulomb Green's function in reciprocal
!   space for small $q$. See the routine gengclq.
!
! !REVISION HISTORY:
!   Created June 2005 (JKD)
!EOP
!BOC
implicit none
! local variables
integer iq,i1,i2,i3
real(8) v0(3),v1(3),t1,t2
open(50,file='GCLQ'//trim(filext),form='FORMATTED')
write(50,'(I6," : nqpt; q-point, vql, gclq below")') nqpt
do iq=1,nqpt
! map the q-vector into the first Brillouin zone
  t1=1.d5
  v0(:)=0.d0
  do i1=-1,1
    do i2=-1,1
      do i3=-1,1
        v1(:)=vqc(:,iq)+dble(i1)*bvec(:,1)+dble(i2)*bvec(:,2) &
         +dble(i3)*bvec(:,3)
        t2=v1(1)**2+v1(2)**2+v1(3)**2
        if (t2.lt.t1) then
          t1=t2
          v0(1)=vql(1,iq)+dble(i1)
          v0(2)=vql(2,iq)+dble(i2)
          v0(3)=vql(3,iq)+dble(i3)
        end if
      end do
    end do
  end do
  write(50,'(I6,4G18.10)') iq,v0,gclq(iq)
end do
close(50)
return
end subroutine
!EOC

