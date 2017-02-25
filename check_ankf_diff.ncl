load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin
    
    if ( .not. isvar(file_in)) then
        print((/"no pass-in var: file_in"/))
        exit 
    end if

    f=addfile(file_in,"r")
    var=(/"T","SPD", "RH"/)
    nvar=dimsizes(type)
    do i=0,nvar-1
        varANKF=var+"ANKF"
        varMOD=var+"mod"
        if(.not. isfilevar(f,varANKF))
            print((/varANKF + " not exist "/))
            continue
        end if
        dataANKF = f->$varANKF$
        dataMOD = f->$varMOD$
        max_abs_diff=max(abs(dataANKF - dataMOD))
        max_diff=max(dataANKF - dataMOD)
        min_diff=min(dataANKF - dataMOD)
        mean_diff=avg(dataANKF - dataMOD)
        str=var+"-Correction: max_abs: "+sprintf("%0.3f", max_abs_diff) + " max: "+sprintf("%0.3f", max_diff) + " min: "+sprintf("%0.3f",min_diff)+ " mean: "+sprintf("%0.3f", mean_diff)
        print((/str/))
    end do
end
