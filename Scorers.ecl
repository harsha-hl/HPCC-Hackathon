IMPORT STD;
IMPORT Scorers_2;
score_1 := Scorers_2.score1;
score_2 := Scorers_2.scorecrim;
sn      := Scorers_2.Suport_Needs;
EXPORT Scorers := MODULE

	EXPORT ErrHandler(REAL Distance,STRING FirstName,STRING LastName,
                    INTEGER Age,REAL Latitude,REAL Longitude):=FUNCTION
    d:= IF(Distance<= 0,0,1);
    f:= IF(FirstName='' OR d=0,0,1);
    l:= IF(LastName=''  OR f=0,0,1);
    a:= IF((Age<18 AND Age!=-1000) OR l=0,0,1);
    lat:=IF((Latitude>180 OR Latitude<-180) OR a=0,0,1);
    lon:=IF((Longitude>180 OR Longitude<-180 ) OR lat=0,0,1);
    ERR := CASE(d+f+l+a+lat+lon,
                0=>'ERROR : Please enter valid distance',
                1=>'ERROR : Please enter firstName',
                2=>'ERROR : Please enter lastname',
                3=>'ERROR : Please enter valid age (18+)',
                4=>'ERROR : Please enter valid latitude value (-180 to 180)',
                5=>'ERROR : Please enter valid longitude value (-180 to 180)',
               		 'Success');
		RETURN ERR;	  
  END;



  
  EXPORT Dist (REAL4  lat1,REAL4  long1,REAL4  lat2,REAL4  long2) := FUNCTION
     lat1_2 := (3.14*lat1)/180;
     long1_2 := (3.14*long1)/180;
     lat2_2 := (3.14*lat2)/180;
     long2_2 := (3.14*long2)/180;
     dlong := long2_2-long1_2;
     dlat := lat2_2-lat1_2;
     Result := POWER(SIN(dlat/2),2)+ COS(lat1_2)*COS(lat2_2)*POWER(SIN(dlong/2),2);
     Result_2 := 2*ASIN(SQRT(Result));
     Result_3 := Result_2*6371;
     RETURN Result_3;
	END;

	EXPORT DistCheck (REAL distlimit, REAL dist) := FUNCTION
    x := IF(dist <= 0.2*distlimit,1,0);
    y := x + IF(dist <= 0.4*distlimit,1,0);
    z := y + IF(dist <= 0.6*distlimit,1,0);
    a := z + IF(dist <= 0.8*distlimit,1,0);
    b := a + IF(dist <= distlimit,1,0);
    RETURN IF(b=0,-1000,b);
	END;

	EXPORT Strng_Comparer (STRING id1, STRING dp1, STRING ds1) := FUNCTION
    id :=STD.Str.ToLowerCase(TRIM(id1));
		dp :=STD.Str.ToLowerCase(TRIM(dp1));
		ds :=STD.Str.ToLowerCase(TRIM(ds1));
    Result := IF(dp=id OR id='na' OR id = 'none' OR id = '',1,0);
    Result2 := Result + IF(ds=id OR (ds='' AND Result!=0) OR id='' OR id = 'none'OR id='na' ,1,0);
    RETURN (IF(Result2=0,0,IF(id='' OR id ='none'OR id='na' ,0,Result2))); //Check
	END;


	EXPORT ReligionScore(STRING Religion,
                       INTEGER1 Religion_Christian,
                       INTEGER1 Religion_Muslim,
                       INTEGER1 Religion_Jewish,
                       INTEGER1 Religion_Hindu,
                       INTEGER1 Religion_Buddhist,
                       INTEGER1 Religion_Other,
                       INTEGER1 Religion_Spiritual,
                       INTEGER1 Religion_None) := FUNCTION
      Religion1 := STD.Str.ToLowerCase(TRIM(Religion));
      ans:= IF(Religion1='islam',score_1(Religion_Muslim),0);
      ans1:=ans+IF(Religion1='spiritual',score_1(Religion_Spiritual),0);
      ans2 := ans1+IF(Religion1='buddhism',score_1(Religion_Buddhist),0);
      ans3 := ans2+IF(Religion1='none',score_1(Religion_None),0);
      ans4 := ans3+ IF(Religion1='hinduism',score_1(Religion_Hindu),0);
      ans5 := ans4 + IF(Religion1='judaism',score_1(Religion_Jewish),0);
      ans6 := ans5 + IF(Religion1='christianity',score_1(Religion_Christian),0);
			RETURN ans6;
		END;


	EXPORT AlcoholScore (STRING  AlcoholUse,
                				 INTEGER1  Alcohol_Occasional,
                         INTEGER1  Alcohol_Responsible,
                         INTEGER1  Alcohol_Irresponsible) := FUNCTION

    InCodes := DATASET([{'Occasionally',Alcohol_Occasional},
                        {'Responsibly',Alcohol_Responsible},
                        {'Irresponsibly',Alcohol_Irresponsible},
                        {'Addicted',Alcohol_Irresponsible}], {STRING in,INTEGER1 score});
    InScoreDCT  := DICTIONARY(InCodes,{in => score});
    MapIn2Score(STRING in)   := InScoreDCT[in].score;
    RETURN IF(AlcoholUse='NA' or AlcoholUse='None',0, IF(MapIn2Score(AlcoholUse)=0,-1000,MapIn2Score(AlcoholUse)));
	END;

	EXPORT DrugScore (STRING  DUse,
                    INTEGER1  DrugUse) := FUNCTION
    InCodes := DATASET([{'Occasionally',DrugUse},
                        {'Regularly',DrugUse},
                        {'Addicted',DrugUse}], {STRING in,INTEGER1 score});
    InScoreDCT  := DICTIONARY(InCodes,{in => score});
    MapIn2Score(STRING in)   := InScoreDCT[in].score;
    RETURN IF(DUse='NA' or DUse='None',0, IF(MapIn2Score(DUse)=0,-1000,MapIn2Score(DUse)));	
	END;


	EXPORT SmokingScore (String smoke,
              INTEGER1  Marijuana_Occasional,
              INTEGER1  Marijuana_Regular,
              INTEGER1  Cigarettes_Occasional,
              INTEGER1 Cigarettes_Regular,
              INTEGER1 Vaping_Occasional,
              INTEGER1  Vaping_Regular) := FUNCTION
  
    maroc := IF(Marijuana_Occasional=0,-1000,Marijuana_Occasional);
    marreg := IF(Marijuana_Regular=0,-1000,Marijuana_Regular);
    cigoc := IF(Cigarettes_Occasional=0,-1000,Cigarettes_Occasional);
    cigreg := IF(Cigarettes_Regular=0,-1000,Cigarettes_Regular);
    vapoc := IF(Vaping_Occasional=0,-1000,Vaping_Occasional);
    vapreg := IF(Vaping_Regular=0,-1000,Vaping_Regular);
    str := STD.Str.ToLowerCase(TRIM(smoke));

    Val1 :=  IF(STD.Str.Find(str,'occasional marijuana',1)>0,maroc,0);
    Val2 := Val1 + IF(STD.Str.Find(str,'regular marijuana',1)>0,marreg,0);  
    Val3 := Val2 + IF(STD.Str.Find(str,'regular cigarettes',1)>0,cigreg,0);
    Val4 := Val3 + IF(STD.Str.Find(str,'occasional cigarettes',1)>0,cigoc,0);
    Val5 := Val4 + IF(STD.Str.Find(str,'occasional vape',1)>0,vapoc,0);
    Val6 := Val5 + IF(STD.Str.Find(str,'regular vape',1)>0,vapreg,0);

    RETURN IF(str='' or STD.Str.Find(str,'none',1)>0,0,Val6);
	END;
	

	EXPORT JobRetentionScore (STRING  Check, INTEGER1  JobRetentionChallenges) := FUNCTION
    InCodes := DATASET([{'checked',JobRetentionChallenges}], {STRING in,INTEGER1 score});
    InScoreDCT  := DICTIONARY(InCodes,{in => score});
    MapIn2Score(STRING in)   := InScoreDCT[in].score;
    RETURN IF(Check='unchecked',0, IF(MapIn2Score(Check)=0,-1000,MapIn2Score(Check)));	
	END;


	EXPORT SocialStyleScore(STRING SocialStyle,
                          INTEGER1 SocialStyle_Introverted,
                          INTEGER1 SocialStyle_Extraverted,
                          INTEGER1 SocialStyle_Both) := FUNCTION
      SocialStyle1 := STD.Str.ToLowerCase(TRIM(SocialStyle));
      ans:= IF(SocialStyle1='introverted',if(SocialStyle_Introverted=0,-1000,SocialStyle_Introverted),0);
      ans1:=ans+IF(SocialStyle1='extraverted',if(SocialStyle_Extraverted=0,-1000,SocialStyle_Extraverted),0);
      ans2 := ans1+IF(SocialStyle1='both',if(SocialStyle_Both=0,-1000,SocialStyle_Both),0);
      ans3 := IF(SocialStyle1='none' OR SocialStyle1='',0,ans2);
    	RETURN ans3;
	END;


	EXPORT CriminalScore(String criminal,
                       INTEGER1 CriminalHistory_Arrested,
                       INTEGER1 CriminalHistory_Jail,
                       INTEGER1 CriminalHistory_CurrentProbation) := FUNCTION
    Criminal1 := STD.Str.ToLowerCase(TRIM(criminal));
		val1 := score_2(Criminal1,'jail',CriminalHistory_Jail);
    val2 := score_2(Criminal1,'current probation',CriminalHistory_CurrentProbation);
    val3 := score_2(Criminal1,'arrested',CriminalHistory_Arrested); 
		RETURN (val1+val2+val3);
	END;


	EXPORT ChildrenScore(String child,
                       INTEGER1 Children_Pregnant,
                       INTEGER1 Children_Custody1,
                       INTEGER1 Children_Custodymultiple,
                       INTEGER1 Children_Kincare1,
                       INTEGER1 Children_Kincaremultiple,
                       INTEGER1 Children_Welfare1,
                       INTEGER1 Children_Welfaremultiple) := FUNCTION
    Children := STD.Str.ToLowerCase(TRIM(child));
		val1 := score_2(Children,'caring for multiple',Children_Custodymultiple);
    val2 := score_2(Children,'1 in kincare',Children_Kincare1);
    val3 := score_2(Children,'1 in welfare',Children_Welfare1);
		val4 := score_2(Children,'pregnant',Children_Pregnant);
		val5 := score_2(Children,'multiple in kincare',Children_Kincaremultiple);
    val6 := score_2(Children,'multiple in welfare',Children_Welfaremultiple);
		val7 := score_2(Children,'caring for 1',Children_Custody1);
		RETURN (val1+val2+val3+val4+val5+val6+val7);

	END;

	EXPORT SexualityScore (STRING  sex,
              			     INTEGER1  Sexuality_Heterosexual,
              			     INTEGER1  Sexuality_Homosexual,
              			     INTEGER1  Sexuality_Bisexual) := FUNCTION
    InCodes := DATASET([{'Homosexual',Sexuality_Homosexual},
                         {'Bisexual',Sexuality_Bisexual},
                         {'Heterosexual',Sexuality_Heterosexual}], {STRING in,INTEGER1 score});
    InScoreDCT  := DICTIONARY(InCodes,{in => score});
    MapIn2Score(STRING in)   := InScoreDCT[in].score;
    RETURN IF(SEX='NA',0, IF(MapIn2Score(sex)=0,-1000,MapIn2Score(sex)));
  END;

	EXPORT GenderScore (STRING  gen,
              				INTEGER1  Gender_Male,
              				INTEGER1  Gender_Female,
              				INTEGER1  Gender_Transgender,
              				INTEGER1  Gender_Non_binary) := FUNCTION
    InCodes := DATASET([{'Male',Gender_Male},
                         {'Female',Gender_Female},
                         {'Transgender',Gender_Transgender },
                         {'Non_Binary',Gender_Non_binary }], {STRING in,INTEGER1 score});
    InScoreDCT  := DICTIONARY(InCodes,{in => score});
    MapIn2Score(STRING in)   := InScoreDCT[in].score;
    RETURN IF(gen='NA',0, IF(MapIn2Score(gen)=0,-1000,MapIn2Score(gen)));
	
	END;


	EXPORT BioRelationshipsScore (STRING  rel,
              								  INTEGER1  Bio_Important,
              							    INTEGER1  Bio_Difficult) := FUNCTION
    InCodes := DATASET([{'Difficult',Bio_Difficult},
                         {'Important',Bio_Important}], {STRING in,INTEGER1 score});
    InScoreDCT  := DICTIONARY(InCodes,{in => score});
    MapIn2Score(STRING in)   := InScoreDCT[in].score;
    RETURN IF(rel='NA' or rel='None',0, IF(MapIn2Score(rel)=0,-1000,MapIn2Score(rel)));
	END;


	EXPORT Ethnicity(STRING ethnicity_youth, STRING ethnicity_mentor ) := FUNCTION
  	RETURN (IF(STD.Str.find(ethnicity_youth,ethnicity_mentor,1)!=0 AND NOT ethnicity_mentor=''AND 
               NOT ethnicity_youth='',1,0));
  END;


	 EXPORT SupportScore(STRING stg1,INTEGER Supports_Parenting,INTEGER Supports_Job,
               INTEGER Supports_Legal,INTEGER Supports_Medical,INTEGER Supports_Budgeting,
               INTEGER Supports_MentalHealth,INTEGER Supports_Resources,INTEGER Supports_Social,
               INTEGER Supports_Holidays) := FUNCTION
     									stg := STD.Str.ToLowerCase(TRIM(stg1));
											// par := sn(stg,Supports_Parenting,'parenting');
											// job := sn(stg,Supports_Job,'job');
											// leg := sn(stg,Supports_Legal,'legal');
											// med := sn(stg,Supports_Medical,'medical');
											// bud := sn(stg,Supports_Budgeting,'budgeting');
											// men := sn(stg,Supports_MentalHealth,'mental health');
											// res := sn(stg,Supports_Resources,'resources');
											// soc := sn(stg,Supports_Social,'social');
											// hol := sn(stg,Supports_Holidays,'holidays');
                      RETURN sn(stg,Supports_Parenting,'parenting')+
                              sn(stg,Supports_Job,'job')+  
                              sn(stg,Supports_Legal,'legal')+
                              sn(stg,Supports_Medical,'medical')+
                              sn(stg,Supports_Budgeting,'budgeting')+
                              sn(stg,Supports_MentalHealth,'mental health')+
                              sn(stg,Supports_Resources,'resources')+
                              sn(stg,Supports_Social,'social')+
                              sn(stg,Supports_Holidays,'holidays');
    									  
                      // par + job + leg + med + bud + men + res + soc + hol
  END;

END;