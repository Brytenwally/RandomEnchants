-- ==========================================================
-- 1. CLEANUP PREVIOUS CUSTOM DATA
-- ==========================================================
DELETE FROM `itemrandomsuffix_dbc` WHERE `ID` >= 5000;
DELETE FROM `item_enchantment_template` WHERE `entry` = 50000;

-- ==========================================================
-- 2. INSERT 40 HIDDEN SUFFIXES (TOTAL BUDGET: 2000)
-- ==========================================================
-- Column mapping: 2802:Agi, 2803:Stam, 2804:Int, 2805:Str, 2806:Spirit, 2824:SP, 
-- 2825:AP, 2822:Crit, 2815:Dodge, 2816:MP5, 2813:Def, 2823:SCrit
-- ==========================================================

INSERT INTO `itemrandomsuffix_dbc` 
(`ID`, `Name_Lang_enUS`, `InternalName`, `Enchantment_1`, `Enchantment_2`, `Enchantment_3`, `AllocationPct_1`, `AllocationPct_2`, `AllocationPct_3`)
VALUES 
-- Singles (2000 budget to one stat)
(5000, '', 'Hidden_Str', 2805, 0, 0, 2000, 0, 0),
(5001, '', 'Hidden_Agi', 2802, 0, 0, 2000, 0, 0),
(5002, '', 'Hidden_Stam', 2803, 0, 0, 2000, 0, 0),
(5003, '', 'Hidden_Int', 2804, 0, 0, 2000, 0, 0),
(5004, '', 'Hidden_Spirit', 2806, 0, 0, 2000, 0, 0),
(5005, '', 'Hidden_SP', 2824, 0, 0, 2000, 0, 0),
(5006, '', 'Hidden_AP', 2825, 0, 0, 2000, 0, 0),
(5007, '', 'Hidden_Crit', 2822, 0, 0, 2000, 0, 0),
(5008, '', 'Hidden_Dodge', 2815, 0, 0, 2000, 0, 0),
(5009, '', 'Hidden_MP5', 2816, 0, 0, 2000, 0, 0),
(5010, '', 'Hidden_Def', 2813, 0, 0, 2000, 0, 0),
(5011, '', 'Hidden_SCrit', 2823, 0, 0, 2000, 0, 0),

-- Doubles (1000 budget split)
(5012, '', 'Hidden_Str_Stam', 2805, 2803, 0, 1000, 1000, 0),
(5013, '', 'Hidden_Agi_Stam', 2802, 2803, 0, 1000, 1000, 0),
(5014, '', 'Hidden_Int_Stam', 2804, 2803, 0, 1000, 1000, 0),
(5015, '', 'Hidden_Spirit_Stam', 2806, 2803, 0, 1000, 1000, 0),
(5016, '', 'Hidden_Str_Crit', 2805, 2822, 0, 1000, 1000, 0),
(5017, '', 'Hidden_Agi_Crit', 2802, 2822, 0, 1000, 1000, 0),
(5018, '', 'Hidden_AP_Crit', 2825, 2822, 0, 1000, 1000, 0),
(5019, '', 'Hidden_Str_AP', 2805, 2825, 0, 1000, 1000, 0),
(5020, '', 'Hidden_Int_SP', 2804, 2824, 0, 1000, 1000, 0),
(5021, '', 'Hidden_Int_SCrit', 2804, 2823, 0, 1000, 1000, 0),
(5022, '', 'Hidden_SP_SCrit', 2824, 2823, 0, 1000, 1000, 0),
(5023, '', 'Hidden_Int_Spirit', 2804, 2806, 0, 1000, 1000, 0),
(5024, '', 'Hidden_Stam_Def', 2803, 2813, 0, 1000, 1000, 0),
(5025, '', 'Hidden_Stam_Dodge', 2803, 2815, 0, 1000, 1000, 0),
(5026, '', 'Hidden_Def_Dodge', 2813, 2815, 0, 1000, 1000, 0),
(5027, '', 'Hidden_SP_MP5', 2824, 2816, 0, 1000, 1000, 0),
(5028, '', 'Hidden_Int_MP5', 2804, 2816, 0, 1000, 1000, 0),

-- Triples (666/666/668 budget split)
(5029, '', 'Hidden_Str_Stam_Crit', 2805, 2803, 2822, 666, 666, 668),
(5030, '', 'Hidden_Agi_Stam_Crit', 2802, 2803, 2822, 666, 666, 668),
(5031, '', 'Hidden_Str_AP_Crit', 2805, 2825, 2822, 666, 666, 668),
(5032, '', 'Hidden_Agi_AP_Crit', 2802, 2825, 2822, 666, 666, 668),
(5033, '', 'Hidden_Int_Stam_SCrit', 2804, 2803, 2823, 666, 666, 668),
(5034, '', 'Hidden_SP_Stam_SCrit', 2824, 2803, 2823, 666, 666, 668),
(5035, '', 'Hidden_Int_SP_SCrit', 2804, 2824, 2823, 666, 666, 668),
(5036, '', 'Hidden_Int_Spirit_MP5', 2804, 2806, 2816, 666, 666, 668),
(5037, '', 'Hidden_Stam_Def_Dodge', 2803, 2813, 2815, 666, 666, 668),
(5038, '', 'Hidden_Str_Agi_Stam', 2805, 2802, 2803, 666, 666, 668),
(5039, '', 'Hidden_Int_SP_Stam', 2804, 2824, 2803, 666, 666, 668);

-- ==========================================================
-- 3. LINK SUFFIXES TO THE RANDOMIZATION POOL
-- ==========================================================
INSERT INTO `item_enchantment_template` (`entry`, `ench`, `chance`)
SELECT 50000, ID, 1 FROM `itemrandomsuffix_dbc` WHERE ID >= 5000;

-- ==========================================================
-- 4. APPLY POOL TO RARE AND EPIC ITEMS IN ITEM_TEMPLATE
-- ==========================================================
UPDATE `item_template` 
SET `RandomSuffix` = 50000, 
    `RandomProperty` = 0 
WHERE `class` IN (2, 4) 
AND `Quality` IN (2, 3, 4);
