/*Check data landscape;
proc contents data = dat.DPASS position; run;
proc contents data = dat.DITa  position; run;
*/

*Combine raw data (DPASS/DPASS_ES) with the imputed data (DITa);
proc sort data = dat.DPASS          out = DPASS;     by subjid; run;
proc sort data = dat.DITa           out = DITa;      by subjid; run;
proc sort data = analysis.analysis1 out = analysis1; by subjid; run;
data check; 
  merge DPASS    (in = in1) 
        DITa     (in = in2)
        analysis1(in = in3); 
  by subjid; 
  if in1 & in2 & in3;
  run;

*Compare imputed data with raw data from all three sources (SFFQ, LFFQ, Recall);

  *Construct macro to perform comparison;
  %macro compare(raw = , derived = , label = );

    title     "Scatterplot for &label Data";
    *footnote  "X-Axis: Raw Data from DPASS Dataset";
    *footnote2 "Y-Axis: Imputed Data from DITa Dataset"; 
      proc sgscatter data = check;
        *plot &derived * (lffq_&raw ravg_&raw sffq_&raw) /columns = 1 reg = (degree = 1 clm nogroup);
        *matrix &derived lffq_&raw ravg_&raw sffq_&raw;
        matrix &derived lffq_&raw ravg_&raw sffq_&raw /diagonal = (histogram normal);
        run;
    title;
    *footnote;
    *footnote2; 

    title "Use Responses to Short FFQ to Model Responses to Long FFQ";
      proc glm data = check noprint;
        model lffq_&raw = sffq_&raw /*male age sffq_supp_use*/ bmi /solution;
        output out = pred_&raw predicted = y_hat_&raw;
        run;
        quit;
    title;

    title     "Compare Predicted LFFQ Values from Validation Model to Observed from SFFQ";
    footnote  "X-Axis: Predicted LFFQ Values";
    footnote2 "Y-Axis: Observed SFFQ Data";
      proc sgscatter data = pred_&raw;
        plot sffq_&raw * y_hat_&raw;
        run;
    title;
    footnote;
    footnote2; 

    /*
    title     "Compare Predicted LFFQ Values from Validation Model to Imputed Values from DPASS";
    footnote  "X-Axis: Predicted Values from DPASS Data";
    footnote2 "Y-Axis: Imputed Data from DITa Dataset";
      proc sgscatter data = pred_&raw;
        plot &derived * y_hat_&raw;
        run;
    title;
    footnote;
    footnote2; 
    */

    /*
    title "Distribution of (Observed - Imputed)";
      data check; set check; delta_&raw = lffq_&raw - &derived; run;
      proc univariate data = check noprint; histogram delta_&raw; run;
    title;
    */

    title "Distribution of (Predicted - Imputed)";
      data pred_&raw; set pred_&raw; delta_hat_&raw = y_hat_&raw - &derived; run;
      proc univariate data = pred_&raw noprint; histogram delta_hat_&raw; run;
    title;

  %mend;
  
%compare(raw = kcal   , derived = DITa7  , label = Energy (Kcal));
/*
%compare(raw = fat    , derived = DITa8  , label = Total Fat (g));
%compare(raw = tcho   , derived = DITa9  , label = Total Carbohydrate (g));
%compare(raw = pro    , derived = DITa10 , label = Total Protein (g));
%compare(raw = apro   , derived = DITa11 , label = Animal Protein (g));
%compare(raw = vpro   , derived = DITa12 , label = Vegetable Protein (g));
%compare(raw = alc    , derived = DITa13 , label = Alcohol (g));
%compare(raw = chol   , derived = DITa14 , label = Cholesterol (mg));
%compare(raw = sfa    , derived = DITa15 , label = Total Saturated Fatty Acid(SFA) (g));
%compare(raw = mfa    , derived = DITa16 , label = Total Monounsaturated Fatty Acid(MUFA) (g));
%compare(raw = pfa    , derived = DITa17 , label = Total Polyunsaturated Fatty Acid(PUFA) (g));
%compare(raw = ttfa   , derived = DITa18 , label = Total Trans-Fatty Acids (g));
%compare(raw = fruc   , derived = DITa19 , label = Fructose (g));
%compare(raw = gala   , derived = DITa20 , label = Galactose (g));
%compare(raw = gluc   , derived = DITa21 , label = Glucose (g));
%compare(raw = lact   , derived = DITa22 , label = Lactose (g));
%compare(raw = malt   , derived = DITa23 , label = Maltose (g));
%compare(raw = sucr   , derived = DITa24 , label = Sucrose (g));
%compare(raw = star   , derived = DITa25 , label = Starch (g));
%compare(raw = dfib   , derived = DITa26 , label = Total Dietary Fiber (g));
%compare(raw = wsdf   , derived = DITa27 , label = Soluble Dietary Fiber (g));
%compare(raw = ifib   , derived = DITa28 , label = Insoluble Dietary Fiber (g));
%compare(raw = pect   , derived = DITa29 , label = Pectins (g));
%compare(raw = vare   , derived = DITa30 , label = Total Vitamin A Activity (RE));
%compare(raw = va     , derived = DITa31 , label = Total Vitamin A Activity (IU));
%compare(raw = bceq   , derived = DITa32 , label = Beta-Carotene Equivalents (Mcg));
%compare(raw = rl     , derived = DITa33 , label = Retinol (Mcg));
%compare(raw = vd     , derived = DITa34 , label = Vitamin D (Mcg));
%compare(raw = atc    , derived = DITa35 , label = Total Vitamin E Activity (mg));
%compare(raw = ttc    , derived = DITa36 , label = Alpha-Tocopherol (mg));
%compare(raw = btc    , derived = DITa37 , label = Beta-Tocopherol (mg));
%compare(raw = gtc    , derived = DITa38 , label = Gamma-Tocopherol (mg));
%compare(raw = dtc    , derived = DITa39 , label = Delta-Tocopherol (mg));
%compare(raw = vk     , derived = DITa40 , label = Vitamin K (Mcg));
%compare(raw = vc     , derived = DITa41 , label = Vitamin C (mg));
%compare(raw = thi    , derived = DITa42 , label = Thiamin (mg));
%compare(raw = rib    , derived = DITa43 , label = Riboflavin (mg));
%compare(raw = nia    , derived = DITa44 , label = Niacin (mg));
%compare(raw = pant   , derived = DITa45 , label = Pantothenic Acid (mg));
%compare(raw = vb6    , derived = DITa46 , label = Vitamin B-6 (mg));
%compare(raw = fol    , derived = DITa47 , label = Folate (Mcg));
%compare(raw = dfe    , derived = DITa48 , label = Dietary folate equivalents (Mcg));
%compare(raw = nfol   , derived = DITa49 , label = Natural folate (Mcg));
%compare(raw = sfol   , derived = DITa50 , label = Synthetic folate (Mcg));
%compare(raw = vb12   , derived = DITa51 , label = Vitamin B-12 (Mcg));
%compare(raw = ca     , derived = DITa52 , label = Calcium (mg));
%compare(raw = p      , derived = DITa53 , label = Phosphorous (mg));
%compare(raw = mg     , derived = DITa54 , label = Magnesium (mg));
%compare(raw = fe     , derived = DITa55 , label = Iron (mg));
%compare(raw = zn     , derived = DITa56 , label = Zinc (mg));
%compare(raw = cu     , derived = DITa57 , label = Copper (mg));
%compare(raw = se     , derived = DITa58 , label = Selenium (Mcg));
%compare(raw = na     , derived = DITa59 , label = Sodium (mg));
%compare(raw = k      , derived = DITa60 , label = Potassium (mg));
%compare(raw = sfa04_0, derived = DITa61 , label = Butyric Acid (g));
%compare(raw = sfa06_0, derived = DITa62 , label = Caproic Acid (g));
%compare(raw = sfa08_0, derived = DITa63 , label = caprylic Acid (g));
%compare(raw = sfa10_0, derived = DITa64 , label = Capric Acid (g));
%compare(raw = sfa12_0, derived = DITa65 , label = Lauric Acid (g));
%compare(raw = sfa14_0, derived = DITa66 , label = Myristic Acid (g));
%compare(raw = sfa16_0, derived = DITa67 , label = Palmitic Acid (g));
%compare(raw = sfa17_0, derived = DITa68 , label = Margaric Acid (g));
%compare(raw = sfa18_0, derived = DITa69 , label = Stearic Acid (g));
%compare(raw = sfa20_0, derived = DITa70 , label = Arachidic Acid (g));
%compare(raw = sfa22_0, derived = DITa71 , label = Behenic Acid (g));
%compare(raw = mfa14_1, derived = DITa72 , label = Myristoleic Acid (g));
%compare(raw = mfa16_1, derived = DITa73 , label = Palmitoleic Acid (g));
%compare(raw = mfa18_1, derived = DITa74 , label = Oleic Acid (g));
%compare(raw = mfa20_1, derived = DITa75 , label = Gadoleic Acid (g));
%compare(raw = mfa22_1, derived = DITa76 , label = Erucic Acid (g));
%compare(raw = pfa18_2, derived = DITa77 , label = Linoleic Acid (g));
%compare(raw = pfa18_3, derived = DITa78 , label = Linolenic Acid (g));
%compare(raw = pfa18_4, derived = DITa79 , label = Parinaric Acid (g));
%compare(raw = pfa20_4, derived = DITa80 , label = Arachidonic Acid (g));
%compare(raw = pfa20_5, derived = DITa81 , label = Eicosapentaenoic Acid (g));
%compare(raw = pfa22_5, derived = DITa82 , label = Docosapentaenoic Acid (g));
%compare(raw = pfa22_6, derived = DITa83 , label = Docosahexaenoic Acid (g));
%compare(raw = tfa16_1, derived = DITa84 , label = Trans-Hexadecenoic Acid (g));
%compare(raw = tfa18_1, derived = DITa85 , label = Trans-Octadecenoic Acid (g));
%compare(raw = tfa18_2, derived = DITa86 , label = Trans-Octadecadienoic Acid (g));
%compare(raw = tryp   , derived = DITa87 , label = Tryptophan (g));
%compare(raw = thre   , derived = DITa88 , label = Threonine (g));
%compare(raw = isol   , derived = DITa89 , label = Isoleucine (g));
%compare(raw = leuc   , derived = DITa90 , label = Leusine (g));
%compare(raw = lysi   , derived = DITa91 , label = Lysine (g));
%compare(raw = meth   , derived = DITa92 , label = Methionine (g));
%compare(raw = cyst   , derived = DITa93 , label = Cystine (g));
%compare(raw = phen   , derived = DITa94 , label = Phenylalanine (g));
%compare(raw = tyro   , derived = DITa95 , label = Tyrosine (g));
%compare(raw = vali   , derived = DITa96 , label = Valine (g));
%compare(raw = argi   , derived = DITa97 , label = Arginine (g));
%compare(raw = hist   , derived = DITa98 , label = Histidine (g));
%compare(raw = alan   , derived = DITa99 , label = Alanine (g));
%compare(raw = aspa   , derived = DITa100, label = Aspartic Acid (g));
%compare(raw = glut   , derived = DITa101, label = Glutamic Acid (g));
%compare(raw = glyc   , derived = DITa102, label = Glycine (g));
%compare(raw = prol   , derived = DITa103, label = Proline (g));
%compare(raw = seri   , derived = DITa104, label = Serine (g));
%compare(raw = aspt   , derived = DITa105, label = Aspartame (mg));
*%compare(raw = sacc   , derived = DITa106, label = Saccharin (mg)); *all values below detectable threshold;
%compare(raw = caff   , derived = DITa107, label = Caffeine (mg));
%compare(raw = phyt   , derived = DITa108, label = Phytic Acid (mg));
%compare(raw = oxal   , derived = DITa109, label = Oxalic Acid (mg));
%compare(raw = mh3    , derived = DITa110, label = 3-Methylhistidine (mg));
*%compare(raw = spoly  , derived = DITa111, label = Sucrose Polyester (g)); *all values below detectable threshold;
%compare(raw = ash    , derived = DITa112, label = Ash (g));
%compare(raw = water  , derived = DITa113, label = Water (g));
%compare(raw = bcaro  , derived = DITa114, label = Beta-Carotene (Mcg));
%compare(raw = acaro  , derived = DITa115, label = Alpha-Carotene (Mcg));
%compare(raw = bcryp  , derived = DITa116, label = Beta-Crytoxanthin (Mcg));
%compare(raw = lz     , derived = DITa117, label = Lutein + Zeaxanthin (Mcg));
%compare(raw = lyco   , derived = DITa118, label = Lycopene (Mcg));
%compare(raw = varae  , derived = DITa119, label = Total Vitamin A Activity (RAE));
%compare(raw = kj     , derived = DITa120, label = Energy: Kilojoules);
%compare(raw = niaeq  , derived = DITa121, label = Niacin Equivalents (mg));
%compare(raw = tsugar , derived = DITa122, label = Total sugars (g));
%compare(raw = omega3 , derived = DITa123, label = Omega 3 fatty acids (g));
%compare(raw = mn     , derived = DITa124, label = Manganese (mg));
%compare(raw = vite   , derived = DITa125, label = Vitamin E (IU));
%compare(raw = natatoc, derived = DITa126, label = Natural Alpha Tocopherol (mg));
%compare(raw = synatoc, derived = DITa127, label = Synthetic Alpha Tocopherol (mg));
%compare(raw = daid   , derived = DITa128, label = Daidzein (mg));
%compare(raw = geni   , derived = DITa129, label = Genistein (mg));
%compare(raw = glyt   , derived = DITa130, label = Glycitein (mg));
%compare(raw = coum   , derived = DITa131, label = Coumestrol (mg));
%compare(raw = bioa   , derived = DITa132, label = Biochanin A (mg));
%compare(raw = formon , derived = DITa133, label = Formonoetin (mg));
*/
