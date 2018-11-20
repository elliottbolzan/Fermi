/*associatedwith symptom disease, condition*/

INSERT INTO Condition VALUES
  (1123, 'Influenza'),
  (1124, 'Hepatitis A'),
  (1125, 'Strep Throat'),
  (1, 'Fever'), /*influenza*/ /*also hep*/ /*also strep*/
  (2, 'Chills'),
  (3, 'Cough'),
  (4, 'Sore throat'),
  (5, 'Runny nose'),
  (6, 'Aching'),
  (7, 'Headache'), /*also hep*/ /*also headache*/
  (8, 'Fatigue'), /*also hep*/
  (9, 'Vomiting'), /*also hep*/ /*strep throat*/
  (10, 'Diarrhea'),
  /*hepatitis*/
  (11, 'Clay-colored bowel movements'),
  (12, 'Loss of appetite'),
  (13, 'Yellow eyes'),
  (14, 'Joint pain'),
  /*strep throat*/
  (15, 'Swollen lymph nodes'),
  (16, 'Swollen tonsils'),
  (17, 'Gut pain');

INSERT INTO Disease VALUES
  (1123, 'Influenza is very scary'),
  (1124, 'Hepatitis is not good for you'),
  (1125, 'Strep throat is very common');

INSERT INTO Category VALUES
  (9000, 'Virus', 'Bad'); 

INSERT INTO OfType VALUES
  (1123, 2123), 
  (1124, 2123), 
  (1125, 2123); 

INSERT INTO Symptom VALUES
  (1, 2), /*influenza*/ /*also hep*/ /*also strep*/
  (2, 2),
  (3, 2),
  (4, 4),
  (5, 5),
  (6, 5),
  (7, 5), /*also hep*/ /*also headache*/
  (8, 6), /*also hep*/
  (9, 6), /*also hep*/ /*strep throat*/
  (10, 6),
  (11, 7),
  (12, 7),

  /*strep throat*/
  (15, 8),
  (16, 9),
  (17, 1);


INSERT INTO AssociatedWith VALUES
  (1, 1123), /*influenza*/ /*also hep*/ /*also strep*/
  (2, 1123),
  (3, 1123),
  (4, 1123),
  (5, 1123),
  (6, 1123),
  (7, 1123), /*also hep*/ /*also headache*/
  (8, 1123), /*also hep*/
  (9, 1123), /*also hep*/ /*strep throat*/
  (10, 1123),
  (11, 1124),
  (12, 1124),

  /*strep throat*/
  (15, 1125),
  (16, 1125),
  (17, 1125),

  (1, 1124), /* not real – just to test similarity query */
  (2, 1124); /* not real – just to test similarity query */

INSERT INTO Profile VALUES
  (3123, 19, 'M'), 
  (3124, 43, 'F'); 

INSERT INTO Has VALUES
  (3123, 1123), 
  (3124, 1125); 