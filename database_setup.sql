-- 1. สร้างฐานข้อมูลและตาราง
CREATE DATABASE IF NOT EXISTS HIS_Kalasin_DB;
USE HIS_Kalasin_DB;

CREATE TABLE Patient_Data (
    HN VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    District VARCHAR(50)
);

CREATE TABLE Visit_Log (
    VN VARCHAR(10) PRIMARY KEY,
    HN VARCHAR(10),
    VisitDate DATE,
    Clinic_Name VARCHAR(50),
    FOREIGN KEY (HN) REFERENCES Patient_Data(HN)
);

CREATE TABLE Diagnosis_Record (
    VN VARCHAR(10),
    ICD10_Code VARCHAR(10),
    Attending_Doctor VARCHAR(100),
    Med_Student VARCHAR(100),
    FOREIGN KEY (VN) REFERENCES Visit_Log(VN)
);

-- 2. ใส่ข้อมูลตัวอย่าง 5 รายการ
INSERT INTO Patient_Data VALUES 
('HN001', 'สมชาย', 'ใจดี', '1980-05-20', 'เมือง'),
('HN002', 'สมหญิง', 'รักเรียน', '1995-11-12', 'ยางตลาด'),
('HN003', 'สมบูรณ์', 'แข็งแรง', '1970-01-01', 'กมลาไสย'),
('HN004', 'มานี', 'มีตา', '1988-08-08', 'ฆ้องชัย'),
('HN005', 'มานะ', 'อดทน', '1982-12-25', 'เมือง');

INSERT INTO Visit_Log VALUES 
('VN69001', 'HN001', '2026-02-15', 'คลินิกอายุรกรรม'),
('VN69002', 'HN002', '2026-01-10', 'คลินิกอายุรกรรม'),
('VN69003', 'HN003', '2026-02-20', 'คลินิกศัลยกรรม'),
('VN69004', 'HN004', '2026-03-05', 'คลินิกอายุรกรรม'),
('VN69005', 'HN005', '2026-04-12', 'คลินิกอายุรกรรม');

INSERT INTO Diagnosis_Record VALUES 
('VN69001', 'E11.9', 'นพ.วิชาญ (อาจารย์)', 'นศพ.เก่งกาจ'),
('VN69002', 'E11.65', 'นพ.วิชาญ (อาจารย์)', 'นศพ.ขยัน'),
('VN69003', 'E11.9', 'นพ.สุรชัย (อาจารย์)', 'นศพ.สมเกียรติ'),
('VN69004', 'K29.7', 'นพ.วิชาญ (อาจารย์)', 'นศพ.เก่งกาจ'),
('VN69005', 'E11.9', 'นพ.วิชาญ (อาจารย์)', 'นศพ.พรชัย');

-- 3. SQL Query สำหรับงานวิจัย (คำตอบข้อ 1)
SELECT 
    p.FirstName, 
    p.LastName, 
    v.VisitDate, 
    d.ICD10_Code, 
    d.Attending_Doctor
FROM Patient_Data p
JOIN Visit_Log v ON p.HN = v.HN
JOIN Diagnosis_Record d ON v.VN = d.VN
WHERE d.ICD10_Code LIKE 'E11%' 
  AND v.Clinic_Name = 'คลินิกอายุรกรรม'
  AND v.VisitDate BETWEEN '2026-01-01' AND '2026-03-31'
ORDER BY v.VisitDate DESC;
