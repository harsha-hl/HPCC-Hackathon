// ****************************************
// MODULEs aren't executable. 
// Please see viewMentors.ecl to see how MODULEs can be called and used.
// ****************************************

EXPORT inputRecords := MODULE

    
    EXPORT MentorsRaw_Rec := RECORD
        STRING       FullName;
        STRING       FirstName;
        STRING       LastName;
        STRING       Gender;
        STRING       Status;
        STRING       Region;
        STRING       Ethnicity;
        STRING       Occupation_primary;
        STRING       MaritalStatus;
        STRING       Spouse_FirstName;
        STRING       Spouse_LastName;
        STRING       Spouse_Gender;
        STRING       Spouse_RaceEthnicity;
        STRING       Spouse_Birthday;
        STRING       Spouse_Age;
        STRING       Spouse_Occupation;
        STRING       Street;
        STRING       City;
        STRING       State;
        STRING       ZipCode;
        INTEGER1     Religion_Christian;
        INTEGER1     Religion_Muslim;
        INTEGER1     Religion_Jewish;
        INTEGER1     Religion_Hindu;
        INTEGER1     Religion_Buddhist;
        INTEGER1     Religion_Other;
        INTEGER1     Religion_Spiritual;
        INTEGER1     Religion_None;
        STRING       RoleofFaith_primary; //done
        STRING       RoleofFaith_spouse;  //done
        INTEGER1     Alcohol_Occasional;
        INTEGER1     Alcohol_Responsible;
        INTEGER1     Alcohol_Irresponsible;
        INTEGER1     DrugUse;
        INTEGER1     Marijuana_Occasional;
        INTEGER1     Marijuana_Regular;
        INTEGER1     Cigarettes_Occasional;
        INTEGER1     Cigarettes_Regular;
        INTEGER1     Vaping_Occasional;
        INTEGER1     Vaping_Regular;
        INTEGER1     JobRetentionChallenges;
        STRING       DayOff_primary;   //done
        STRING       DayOff_spouse;		 //done
        STRING       FavoritPlace_primary; //done
        STRING       FavoritePlace_spouse; //done
        STRING       Personality_primary;  //done
        STRING       Personality_spouse;	//done
        INTEGER1     SocialStyle_Introverted;
        INTEGER1     SocialStyle_Extraverted;
        INTEGER1     SocialStyle_Both;
        STRING       SadnessResponse_primary; //done
        STRING       SadnessResponse_spouse;  //done
        STRING       AngerResponse_primary;   //done
        STRING       AngerResponse_spouse;		//done
        INTEGER1     ContinuingEducation;
        INTEGER1     Supports_Holidays;
        INTEGER1     Supports_Job;
        INTEGER1     Supports_Parenting;
        INTEGER1     Supports_Medical;
        INTEGER1     Supports_Legal;
        INTEGER1     Supports_Budgeting;
        INTEGER1     Supports_MentalHealth;
        INTEGER1     Supports_Resources;
        INTEGER1     Supports_Social;
        STRING       Multiple_Matches;
        STRING       Match_Housing;
        STRING       Emergency_Housing;
        INTEGER1     CriminalHistory_Arrested;
        INTEGER1     CriminalHistory_Jail;
        INTEGER1     CriminalHistory_CurrentProbation;
        INTEGER1     Children_Pregnant;
        INTEGER1     Children_Custody1;
        INTEGER1     Children_Custodymultiple;
        INTEGER1     Children_Kincare1;
        INTEGER1     Children_Kincaremultiple;
        INTEGER1     Children_Welfare1;
        INTEGER1     Children_Welfaremultiple;
        INTEGER1     Bio_Important;
        INTEGER1     Bio_Difficult;
        INTEGER1     Sexuality_Heterosexual;
        INTEGER1     Sexuality_Homosexual;
        INTEGER1     Sexuality_Bisexual;
        INTEGER1     Gender_Male;
        INTEGER1     Gender_Female;
        INTEGER1     Gender_Transgender;
        INTEGER1     Gender_Non_binary;
        REAL4        Latitude;          //done
        REAL4        Logatitude;				//done
    END;

    EXPORT MentorsRaw_DS   := DATASET('~raw::connectionshomes::mentoringfamilies.csv', MentorsRaw_Rec, CSV(HEADING(1)));

    
    EXPORT YouthRaw_Rec := RECORD
        STRING    FullName;
        STRING    FirstName;
        STRING    LastName;
        STRING    Street;
        STRING    City;
        STRING    State;
        STRING    ZipCode;
        STRING    Region;
        STRING    Birthday;
        INTEGER1  Age;
        STRING    Race_Ethnicity;
        STRING    Religion;
        STRING    RoleofFaith;
        STRING    AlcoholUse;
        STRING    Smoking;
        STRING    JobRetentionChallenges;
        STRING    DayOff;
        STRING    FavoritePlace;
        STRING    Personality;
        STRING    SocialStyle;
        STRING    SadnessResponse;
        STRING    AngerResponse;
        STRING    ContinuingEducation; 
        STRING    SupportNeeds;
        STRING    LivingSituation;
        STRING    CriminalHistory;
        STRING    Children;
        STRING    BioRelationships;
        STRING    Sexuality;
        STRING    GenderIdentity;
        REAL4     Latitude;
        REAl4     Logatitude;
    END;
		
END;

