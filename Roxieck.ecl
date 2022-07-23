IMPORT Scorers;
IMPORT inputRecords;
DS := inputRecords.MentorsRaw_DS;
rs := Scorers.ReligionScore;
Res := RECORD
    		DS;
				INTEGER       	 TOTAL;
END;
SampleRec := RECORD
    REAL     Distance;    
    STRING   FirstName;     
    STRING   LastName;    
    STRING   ZipCode;    
    INTEGER  Region;      
    STRING   Birthday;      
    INTEGER  Age;     		
    STRING   Race_Ethnicity;  
    STRING   Religion;			
    STRING   RoleofFaith;   
    STRING   AlcoholUse;		
		STRING   DrugUse;				
		STRING   Smoking;				
		STRING   JobRetentionChallenges; 
		STRING   DayOff;							
		STRING   FavoritePlace;				
		STRING   Personality;					
		STRING   SocialStyle;   			
		STRING   SadnessResponse;			
		STRING   AngerResponse;				
		STRING   ContinuingEducation;	
		STRING   SupportNeeds;				
		STRING   CriminalHistory;			
		STRING   Children;						
		STRING   Sexuality;						
		STRING   Gender;
		STRING   BioRelationships;
		REAL     Latitude;						
		REAL     Longitude;					 
		
		
END;  

_Distance         := 1000 : STORED('Distance', FORMAT(SEQUENCE(1)));
_FirstName        := 'fc':STORED('FirstName', FORMAT(SEQUENCE(2)));
_LastName         := 'de': STORED('LastName', FORMAT(SEQUENCE(3)));
_ZipCode          := '' : STORED('ZipCode', FORMAT(SEQUENCE(7)));
_Region           := '' : STORED('Region', FORMAT(SEQUENCE(8)));
_Birthday         := '' : STORED('Birthday', FORMAT(SEQUENCE(9)));
_Age              := 20  : STORED('Age', FORMAT(SEQUENCE(10)));
_Race_Ethnicity   := '' : STORED('Race_Ethnicity', FORMAT(SEQUENCE(11)));
Religion          := '' : STORED('Religion', FORMAT(SEQUENCE(12), 
                          SELECT('NA=NA,Christianity=Christianity,Islam=Islam,Judaism=Judaism,Spiritual=Spiritual,Hinduism=Hinduism,Other=Other,None=None')));
RoleofFaith       := '' : STORED('RoleofFaith', FORMAT(SEQUENCE(13),
                          SELECT('NA=NA,Unimportant=Unimportant,Exclusive=Exclusive,Inclusive=Inclusive,None=None')));
AlcoholUse        := '' : STORED('AlcoholUse', FORMAT(SEQUENCE(14), 
                          SELECT('NA=NA,Occasionally=Occasionally,Responsibly=Responsibly,Irresponsibly=Irresponsibly,Addicted=Addicted,None=None')));
DrugUse						:= '' : STORED('DrugUse',FORMAT(SEQUENCE(15),
                          SELECT('NA=NA,Occasionally=Occasionally,Regularly=Regularly,Addicted=Addicted,None=None')));
Smoking           := '' : STORED('Smoking',FORMAT(SEQUENCE(16)));
JobRetentionChallenges  := '' : STORED('JobRetentionChallenges',FORMAT(SEQUENCE(17),
                          		  SELECT('unchecked=unchecked,checked=checked')));
DayOff       			:= '' : STORED('DayOff', FORMAT(SEQUENCE(18),
                          SELECT('NA=NA,Home=Home,Friends/Family=Friends/Family,Movie/Play=Movie/Play,Read/Walk=Read/Walk,Shop=Shop,None=None')));
FavoritePlace     := '' : STORED('FavoritePlace', FORMAT(SEQUENCE(19),
                          SELECT('NA=NA,Nature=Nature,New=New,Pampered=Pampered,Event=Event,None=None')));
Personality       := '' : STORED('Personality',FORMAT(SEQUENCE(20)));
SocialStyle       := '' : STORED('SocialStyle',FORMAT(SEQUENCE(21)));
SadnessResponse   := '' : STORED('SadnessResponse',FORMAT(SEQUENCE(22)));
AngerResponse     := '' : STORED('AngerResponse',FORMAT(SEQUENCE(23)));
ContinuingEducation     := '' : STORED('ContinuingEducation',FORMAT(SEQUENCE(24),
													      SELECT('unchecked=unchecked,checked=checked')));
SupportNeeds      := '' : STORED('SupportNeeds',FORMAT(SEQUENCE(25)));
CriminalHistory   := '' : STORED('CriminalHistory',FORMAT(SEQUENCE(26)));
Children          := '' : STORED('Children',FORMAT(SEQUENCE(27)));
Sexuality         := '' : STORED('Sexuality', FORMAT(SEQUENCE(28), 
                          SELECT('NA=NA,Homosexual=Homosexual,Heterosexual=Heterosexual,Bisexual=Bisexual')));
Gender        		:= '' : STORED('Gender', FORMAT(SEQUENCE(29), 
                          SELECT('NA=NA,Male=Male,Female=Female,Transgender=Transgender,Non_Binary=Non_Binary')));
BioRelationships  := '' : STORED('BioRelationships', FORMAT(SEQUENCE(30), 
                          SELECT('NA=NA,Difficult=Difficult,Important=Important,None=None')));
Latitude          := 0: STORED('Latitude',FORMAT(SEQUENCE(31)));
Longitude         := 0: STORED('Longitude',FORMAT(SEQUENCE(32)));

SampleDS := DATASET([{_Distance, _FirstName,_LastName, _ZipCode, _Region, 
                     _Birthday, _Age, _Race_Ethnicity, Religion, RoleofFaith, AlcoholUse,DrugUse,Smoking,JobRetentionChallenges,
                     DayOff,FavoritePlace,Personality,SocialStyle,SadnessResponse,AngerResponse,ContinuingEducation,SupportNeeds,
                     CriminalHistory,Children,Sexuality,Gender,BioRelationships,Latitude,Longitude}], 
                     SampleRec);




OUTPUT(SampleDS, NAMED('SampleDS'));
Human_Review :=IF(Religion='NA','Religion  ','')+IF(AlcoholUse='NA','AlcoholUse  ','')+ 
  						 IF(DrugUse='NA','DrugUse  ','')+ IF(Smoking='','Smoking  ','')+ IF(DayOff='NA','DayOff  ','')+
               IF(FavoritePlace='NA','FavoritePlace  ','')+ IF(Personality='','Personality  ','')+
               IF(SocialStyle='','SocialStyle  ','')+ IF(SadnessResponse='','SadnessResponse  ','')+
               IF(AngerResponse='','AngerResponse  ','')+ IF(SupportNeeds='','SupportNeeds  ','')+
      				 IF(CriminalHistory='','CriminalHistory  ','')+ IF(Children='','Children  ','')+
               IF(Sexuality='NA','Sexuality  ','') + IF(BioRelationships='NA','BioRelationships  ',''); 
OUTPUT(IF(Human_Review='','None',Human_Review),NAMED('Human_Review'));
                 
// First Name, Second Name, Distance, Lat, Longitude, Age

Err := Scorers.ErrHandler(_Distance,
                          _FirstName,
                          _LastName,
                          _Age,
                          Latitude,
                          Longitude);
Throw := IF(Err='Success','Query Success',ERROR(0,Err));
OUTPUT(Throw,NAMED('Query_Status'));
                 
                 
                 
                 
                 
// IF(Err='Success','Query Success',FAIL(0,'Failure'));
// F := FAIL(101,'hi');
// OUTPUT(Fa);

// SEQUENTIAL(_Distance,Act1,Err,Throw,ACT2);                

ProjResult := PROJECT(DS,
                    TRANSFORM(Res,
											
                      T0  :=(INTEGER)Scorers.DistCheck(_Distance,
                                               (REAL)Scorers.Dist(Latitude,Longitude,LEFT.Latitude,LEFT.Logatitude));
                              
                      T1 := (INTEGER)Scorers.ReligionScore(Religion,LEFT.Religion_Christian,LEFT.Religion_Muslim,
                                                         LEFT.Religion_Jewish,LEFT.Religion_Hindu,LEFT.Religion_Buddhist,
                                                         LEFT.Religion_Other,LEFT.Religion_Spiritual,LEFT.Religion_None);
                              
                              
                      T2 :=  (INTEGER)Scorers.Strng_Comparer(RoleofFaith,LEFT.RoleofFaith_primary,LEFT. RoleofFaith_spouse); 
                         
                      T3 :=  (INTEGER)Scorers.AlcoholScore(AlcoholUse,LEFT.Alcohol_Occasional,LEFT.Alcohol_Responsible,
                                                           LEFT.Alcohol_Irresponsible);
                      T4 :=  (INTEGER)Scorers.DrugScore(DrugUse,LEFT.DrugUse);
                              
                      T5 :=  (INTEGER)Scorers.SmokingScore(Smoking,LEFT.Marijuana_Occasional,LEFT.Marijuana_Regular,
                                                           LEFT.Cigarettes_Occasional,LEFT.Cigarettes_Regular,
                                                           LEFT.Vaping_Occasional,LEFT.Vaping_Regular);
                      T6 := (INTEGER)Scorers.JobRetentionScore(JobRetentionChallenges,
                                                               LEFT.JobRetentionChallenges);
                      T7 := (INTEGER)Scorers.Strng_Comparer(DayOff,LEFT.DayOff_primary,LEFT.DayOff_spouse);
                      T8 := (INTEGER)Scorers.Strng_Comparer(FavoritePlace,LEFT.FavoritPlace_primary,
                                                            LEFT.FavoritePlace_spouse);
                      T9 := (INTEGER)Scorers.Strng_Comparer(Personality,LEFT.Personality_primary,
                                                            LEFT.Personality_spouse);
                      T10 := (INTEGER)Scorers.SocialStyleScore(SocialStyle,LEFT.SocialStyle_Introverted,
                                                               LEFT.SocialStyle_Extraverted,LEFT.SocialStyle_Both);
                              
                      T11 := (INTEGER)Scorers.Strng_Comparer(SadnessResponse,LEFT.SadnessResponse_primary,
                                                            LEFT.SadnessResponse_spouse);
                      T12 := (INTEGER)Scorers.Strng_Comparer(AngerResponse,LEFT.AngerResponse_primary,
                                                            LEFT.AngerResponse_spouse);
                      //ContinuingEducation
                      T13 := (INTEGER)Scorers.JobRetentionScore(ContinuingEducation,
                                                               LEFT.ContinuingEducation);
                      T14 := (INTEGER)Scorers.CriminalScore(CriminalHistory,LEFT.CriminalHistory_Arrested,
                                                            LEFT.CriminalHistory_Jail,
                                                            LEFT.CriminalHistory_CurrentProbation);
                      T15 := (INTEGER)Scorers.ChildrenScore(Children,LEFT.Children_Pregnant,
                                                            LEFT.Children_Custody1,
                                                            LEFT.Children_Custodymultiple,
                                                            LEFT.Children_Kincare1,
                                                            LEFT.Children_Kincaremultiple,
                                                            LEFT.Children_Welfare1,
                                                            LEFT.Children_Welfaremultiple);
                              
                      T16 := (INTEGER)Scorers.SexualityScore(Sexuality,LEFT.Sexuality_Heterosexual,
                                                             LEFT.Sexuality_Homosexual,
                                                             LEFT.Sexuality_Bisexual);
                      T17 := (INTEGER)Scorers.GenderScore(Gender,LEFT.Gender_Male,LEFT.Gender_Female,
                                                          LEFT.Gender_Transgender,LEFT.Gender_Non_binary);
                      T18 := (INTEGER)Scorers.BioRelationshipsScore(BioRelationships,LEFT.Bio_Important,
                                                                    LEFT.Bio_Difficult);
                      
                      T19 := (INTEGER)Scorers.Ethnicity(_Race_Ethnicity,LEFT.Ethnicity);
                      
                      T20 := (INTEGER)Scorers.SupportScore(SupportNeeds,LEFT.Supports_Parenting,LEFT.Supports_Job,
                                                           LEFT.Supports_Legal,
                                                           LEFT.Supports_Medical,LEFT.Supports_Budgeting,
                                                           LEFT.Supports_MentalHealth,LEFT.Supports_Resources,
                                                           LEFT.Supports_Social,
                                                           LEFT.Supports_Holidays);
                      
                      SELF.TOTAL := T0+T1+T2+T3+T4+T5+T6+T7+T8+T9+T10+T11+T12+T13+T14+T15+T16+T17+T18+T19+T20;
										
                              
                          
                      SELF := LEFT;  
                    ));
                 
OUTPUT(COUNT(ProjResult(TOTAL>0)),NAMED('Number_Of_Matches'));
OUTPUT(SORT(ProjResult(TOTAL>0),-TOTAL), NAMED('ProjResult'));