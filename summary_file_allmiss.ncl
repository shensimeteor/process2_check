load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

    if ( .not. isvar(file_in)) then
        print((/"no pass-in var: file_in"/))
        exit 
    end if
    
    f=addfiles(files,"r")
    type=(/"obs","mod","ANKF"/)
    ntype=dimsizes(type)
    var=(/"T","SPD", "RH"/)
    nvar=dimsizes(type)
    do i=0, ntype-1
        print(" ---------------------")
        print("to summary allmissing for " + type(i))
        do j=0, nvar-1
            print("- "+var(j))
            varname = var(j)+type(i)
            if(.not. isfilevar(f, varname)) then
                continue
            end if
            ncyc=dimsizes(f->cycle)
            is_all_missing = new((/ncyc/), logical); if all station/forecast_time is missing, then true
            str = ""
            do t=0, ncyc-1
                is_all_missing(t) = all(ismissing( f->$varname$(t,:,0,:)))
                if(is_all_missing(t)) then
                    str = str + sprinti("%d",toint(f->cycle(t))) + " M;"
                else
                    str = str + sprinti("%d", toint(f->cycle(t))) + "  ;"
                end if
            end do
            print((/str/))
            delete(is_all_missing)
        end do
    end do








end
