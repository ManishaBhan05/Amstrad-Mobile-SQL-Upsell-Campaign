SELECT            CB.ContactKey, 
                  CB.EmailAddress, 
                  
                  /* CURRENT PLAN */
                  PM.PlanID AS Last_PlanID, 
                  PM.PlanName AS Last_PlanName, 
                  PM.DataGB AS Last_DataGB, 
                  PM.Price AS Last_Price, 
                  
                  /* UPGRADE PLAN A */
                  A.PlanID AS UpgradeA_PlanID, 
                  A.PlanName AS UpgradeA_Name, 
                  A.DataGB AS UpgradeA_DataGB, 
                  A.Price AS UpgradeA_Price, 
                  
                   /* UPGRADE A - DATA AND PRICE DIFFERENCE */
                  (A.DataGB - PM.DataGB) AS UpgradeA_DataDiff, 
                  (A.Price - PM.Price) AS UpgradeA_PriceDiff, 
                  
                  /* PERSONALIZED UPGRADE A LINK */
                  CONCAT(A.DeepLinkBase,'&ck=',CB.ContactKey) AS UpgradeA_URL,
                  
                  /* UPGRADE PLAN B */
                  B.PlanID AS UpgradeB_PlanID, 
                  B.PlanName AS UpgradeB_Name, 
                  B.DataGB AS UpgradeB_DataGB, 
                  B.Price AS UpgradeB_Price,
                  
                  /* UPGRADE B - DATA AND PRICE DIFFERENCE */
                  (B.DataGB - PM.DataGB) AS UpgradeB_DataDiff, 
                  (B.Price - PM.Price) AS UpgradeB_PriceDiff, 
                  
                  /* PERSONALIZED UPGRADE B LINK */
                  CONCAT(B.DeepLinkBase,'&ck=',CB.ContactKey) AS UpgradeB_URL,
                  
                  /* RECOMMENDED PLAN BASED ON DATA USAGE */
                  CASE
                         WHEN CB.AvgDataUsageGB90 > A.DataGB
                         THEN B.PlanID
                         ELSE A.PlanID
                  END AS RecommendedPlan
                  
FROM              [CustomerBase] CB

/* MATCH CUSTOMER'S CURRENT PLAN */
INNER JOIN        [PlanMatrix] PM
ON                CB.LastPlanID = PM.PlanID

/* GET UPGRADE PLAN A DETAILS */
INNER JOIN        [PlanMatrix] A
ON                PM.UpgradeA_PlanID = A.PlanID

/* GET UPGRADE PLAN B DETAILS */
INNER JOIN        [PlanMatrix] B
ON                PM.UpgradeB_PlanID = B.PlanID

/* ONLY ACTIVE CUSTOMERS */
WHERE             CB.LifecycleStatus = 'Active'

/* HAVE OPTED INTO EMAILS */
AND               CB.EmailOptIn = 1 

/* DON'T HAVE LOW SPEND (ARPU<10) */
AND               CB.ARPU >= 10


/* DON'T HAVE PLAN IDS -P120, P145, P098, P119 */
AND              PM.PlanID NOT IN ('P120', 'P145', 'P098', 'P119')

/* ARE NOT LINKED TO BLOCKED UPGRADE PLANS -P120, P200 */
AND              A.PlanID NOT IN ('P120', 'P200')
AND              B.PlanID NOT IN ('P120', 'P200')


