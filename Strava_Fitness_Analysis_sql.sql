	CREATE DATABASE fitness_analysis;
    USE fitness_analysis;
    SHOW DATABASES;
    CREATE TABLE merged_daily (
    Id BIGINT,
    ActivityDate DATETIME,
    TotalSteps INT,
    TotalDistance FLOAT,
    TrackerDistance FLOAT,
    LoggedActivitiesDistance FLOAT,
    VeryActiveDistance FLOAT,
    ModeratelyActiveDistance FLOAT,
    LightActiveDistance FLOAT,
    SedentaryActiveDistance FLOAT,
    VeryActiveMinutes INT,
    FairlyActiveMinutes INT,
    LightlyActiveMinutes INT,
    SedentaryMinutes INT,
    Calories INT,
    Date DATE,
    SleepDay DATETIME,
    TotalSleepRecords INT,
    TotalMinutesAsleep INT,
    TotalTimeInBed INT,
    HoursAsleep FLOAT,
    HoursInBed FLOAT,
    SleepEfficiency FLOAT,
    WeightKg FLOAT,
    WeightPounds FLOAT,
    BMI FLOAT
);
CREATE TABLE merged_hourly (
    Id BIGINT,
    ActivityHour DATETIME,
    DayOfWeek VARCHAR(20),
    Hour INT,
    StepTotal INT,
    Calories INT,
    TotalIntensity INT,
    AverageIntensity FLOAT
);
SHOW TABLES;
DROP TABLE daily_activity;
SELECT * 
FROM merged_daily
LIMIT 10;
SELECT COUNT(*) 
FROM merged_daily;
SELECT *
FROM merged_hourly
limit 10; 
select count(*)
from merged_hourly;
# When users are most physically active during the day # 
   select Hour,
    ROUND(AVG(StepTotal),2) AS avg_steps,
    ROUND(AVG(Calories),2) AS avg_calories
FROM merged_hourly
GROUP BY Hour
ORDER BY avg_steps DESC;
# Periods when users are least active (likely sleep or work hours) # 
SELECT 
    Hour,
    AVG(StepTotal) AS avg_steps
FROM merged_hourly
GROUP BY Hour
ORDER BY avg_steps ASC
LIMIT 5;
# How intensity influences calorie burn # 
SELECT
    ROUND(AVG(TotalIntensity),2) AS avg_intensity,
    ROUND(AVG(Calories),2) AS avg_calories
FROM merged_hourly;
# How efficiently users convert bed time into actual sleep.
SELECT
    ROUND(AVG(TotalMinutesAsleep),2) AS avg_sleep_minutes,
    ROUND(AVG(TotalTimeInBed),2) AS avg_time_in_bed,
    ROUND(AVG(SleepEfficiency),2) AS avg_sleep_efficiency
FROM merged_daily;
# Whether more active users sleep longer.
SELECT
    ROUND(AVG(TotalSteps),2) AS avg_steps,
    ROUND(AVG(TotalMinutesAsleep),2) AS avg_sleep
FROM merged_daily;
# User lifestyle segmentation.
SELECT
    CASE
        WHEN TotalSteps < 5000 THEN 'Low Activity'
        WHEN TotalSteps BETWEEN 5000 AND 10000 THEN 'Moderate Activity'
        ELSE 'High Activity'
    END AS activity_level,
    COUNT(*) AS users
FROM merged_daily
GROUP BY activity_level;
# weight Logging Coverage 
SELECT
    COUNT(*) AS total_records,
    COUNT(WeightKg) AS weight_records,
    ROUND(COUNT(WeightKg) * 100.0 / COUNT(*), 2) AS weight_record_pct
FROM merged_daily;


