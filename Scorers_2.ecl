IMPORT STD;
EXPORT Scorers_2 := MODULE
  EXPORT score1(INTEGER1 var) := FUNCTION
    RETURN if(var=0,-1000,var);
  END;

	EXPORT scorecrim(String st, String x, INTEGER1 var) := FUNCTION
       res1 := if((st='' OR st='none'),0,1);
       res2 := if(STD.Str.findcount(st,x)>=1 AND var=0,-1000,0);
       RETURN (res2*res1+res1*if(STD.Str.findcount(st,x)>=1,var,0));
	END;
	EXPORT Suport_Needs(STRING ans, INTEGER var, STRING cur) := FUNCTION 
    Res1 := IF(ans='' OR ans='none',0,1);
    Res2 := IF(STD.Str.findcount(ans,cur)>=1 AND var=0,-1000,0);
    RETURN (Res2*Res1+Res1*IF(STD.Str.findcount(ans,cur)>=1,var,0));
	END;
END;