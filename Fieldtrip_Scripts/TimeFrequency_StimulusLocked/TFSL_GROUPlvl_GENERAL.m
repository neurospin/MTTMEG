function TFSL_GROUPlvl_GENERAL(niplist,chansel,condnames,selection,latency,graphcolor,stat_test,foi,isind,varargin)


if length(selection) == 2
    if isempty(varargin)
        TFSL_GROUPlvl_select(niplist,chansel,condnames,selection,latency,graphcolor,stat_test,foi,isind)
    else
        TFSL_GROUPlvl_vsZERO(niplist,chansel,condnames,selection,latency,graphcolor,stat_test,foi,isind,varargin{1})
    end
elseif length(condnames) == 3
    TFSL_GROUPlvl_REG(niplist,chansel,condnames,latency,graphcolor,stat_test,foi,isind)
elseif length(condnames) == 4
    TFSL_GROUPlvl_REG4lvl(niplist,chansel,condnames,latency,graphcolor,stat_test,foi)
end





