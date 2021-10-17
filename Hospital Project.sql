-- 1. Obtain the names of all physicians that have performed a medical 
--    procedure they have never been certified to perform.

SELECT DISTINCT py.Name
FROM Undergoes un LEFT JOIN Trained_In ti 
ON   ti.Physician = un.Physician
AND  ti.Treatment = un.or_procedure
				 LEFT JOIN Physician py 
ON   un.Physician = py.EmployeeID
WHERE ti.CertificationDate IS NULL

-- 2. Obtain the names of all physicians that have performed a medical procedure that they are 
--   certified to perform, but such that the procedure was done at a date (Undergoes.Date) 
--   after the physician's certification expired (Trained_In.CertificationExpires).

SELECT DISTINCT py.Name
FROM Undergoes un LEFT JOIN Trained_In ti 
ON   ti.Physician = un.Physician
AND  ti.Treatment = un.or_procedure
				 LEFT JOIN Physician py 
ON   un.Physician = py.EmployeeID
WHERE ti.CertificationExpires < un.DateUndergoes

-- 3. Obtain the information for appointments where a patient met with a 
--    physician other than his/her primary care physician. 
--    Show the following information: Patient name, physician name, nurse name (if any), 
--    start and end time of appointment, examination room, 
--    and the name of the patient's primary care physician.

SELECT pat.Name AS 'patient_name', 
       py.Name  AS 'physician_name', 
	   nu.Name  AS 'nurse_name', 
	   apt.Start_time AS 'start_time',
	   apt.end_time AS 'end_time',
	   apt.ExaminationRoom AS 'room',
	   primary_py.name AS 'primary_physician'
FROM Appointment apt JOIN Patient pat 
ON   apt.Patient = pat.SSN
					 JOIN Physician py 
ON   apt.Physician = py.EmployeeID
					LEFT OUTER JOIN nurse nu
ON   apt.PrepNurse = nu.EmployeeID
					JOIN Physician primary_py
ON   primary_py.EmployeeID = pat.PCP
WHERE apt.Physician <> pat.PCP
					
-- 4. The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. 
--    There are no constraints in force to prevent inconsistencies between these two tables. 
--    More specifically - the Undergoes table may include a row where the patient ID does not match the one we would obtain from 
--    the Stay table.
--    Select all rows from Undergoes that exhibit this inconsistency.

SELECT un.Stay AS 'stay', 
       un.Patient AS 'patient_id_from_undergoes', 
	   st.Patient AS 'patient_id_from_stay'
FROM Undergoes un LEFT JOIN stay st 
ON   st.StayID= un.Stay
WHERE un.Patient <> st.Patient 


-- 5. Obtain the names of all the nurses who have ever been on call for room 123.

SELECT DISTINCT nu.Name
FROM On_Call oc JOIN room ro
ON   oc.BlockFloor= ro.BlockFloor
AND  oc.BlockCode = ro.BlockCode
				JOIN Nurse nu
ON   oc.Nurse = nu.EmployeeID
WHERE ro.RoomNumber = 123

-- 6. The hospital has several examination rooms where appointments take place. 
--    Obtain the number of appointments that have taken place in each examination room.

SELECT ExaminationRoom, COUNT(AppointmentID) AS Number FROM Appointment
GROUP BY ExaminationRoom;

-- 7. Obtain the names of all patients who have been prescribed some medication by their primary care 
--    physician

SELECT DISTINCT pt.name
FROM patient pt JOIN prescribes pr 
ON   pt.SSN = pr.Patient
WHERE pt.PCP = pr.Physician

-- 8. Obtain the names of all patients who have been undergone a procedure with a cost larger that $5,000

SELECT DISTINCT pt.name
FROM Patient pt JOIN Undergoes un 
ON   pt.SSN = un.Patient
				JOIN or_procedure orp 
ON   un.or_procedure = orp.Code
WHERE orp.Cost > 5000 

-- 9. Obtain the names of all patients who have had at least two appointments 

SELECT pt.Name, COUNT(ap.AppointmentID) AS 'num_of_appointments'
FROM Appointment ap JOIN Patient pt 
ON   pt.SSN = ap.Patient
GROUP BY pt.name 				
HAVING COUNT(ap.AppointmentID) >= 2 

-- 10. Obtain the names of all patients which their care physician is not the head of any department 

SELECT p.Name
FROM patient p LEFT JOIN Department d 
ON p.pcp=d.Head
WHERE d.Head is null
