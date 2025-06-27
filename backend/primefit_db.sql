CREATE DATABASE IF NOT EXISTS `primefit`;
USE `primefit`;

-- Store (Products) Table
CREATE TABLE `store` (
  `product_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL CHECK (price >= 0),
  `stock` int NOT NULL DEFAULT 0,
  `supplier` varchar(100) NOT NULL,
  `categories` enum('All','Gym Equipment','Gym Attire','Fitness Trackers') DEFAULT 'All',
  `image_url` JSON NULL,
  INDEX idx_category (`categories`),
  INDEX idx_name (`name`)
) AUTO_INCREMENT= 10001;

CREATE TABLE `trainers` (
  `trainer_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL UNIQUE,
  `specialization` varchar(255) NOT NULL,
  `experience` int NOT NULL,
  `image_url` varchar(255) NOT NULL DEFAULT ''
) AUTO_INCREMENT= 30001;

CREATE TABLE `plan_types` (
  `type_id` INT AUTO_INCREMENT PRIMARY KEY,
  name ENUM('Basic', 'Pro', 'Premium') NOT NULL UNIQUE
)AUTO_INCREMENT = 50001;

CREATE TABLE `plans` (
  `plan_id` INT AUTO_INCREMENT PRIMARY KEY,
   `type_id` INT,
  `price` decimal(10,2) NOT NULL,
  `duration_months` ENUM('12 months','24 months','36 months') NOT NULL DEFAULT '12 months',
  FOREIGN KEY (`type_id`) REFERENCES plan_types(`type_id`) ON DELETE CASCADE
) AUTO_INCREMENT= 51001;

CREATE TABLE `plan_features` (
  `feature_id` INT AUTO_INCREMENT PRIMARY KEY,
  `type_id` INT,
  `plan_id` INT NOT NULL,
  `feature` VARCHAR(255) NOT NULL,
  FOREIGN KEY (`plan_id`) REFERENCES `plans`(`plan_id`) ON DELETE CASCADE,
  FOREIGN KEY (`type_id`) REFERENCES plan_types(`type_id`) ON DELETE CASCADE
) AUTO_INCREMENT = 52001;

CREATE TABLE `users` (
  `user_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255)  NULL,
  `email` varchar(255) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `address` varchar(255)  NULL,
  `plan_id` int NULL,
  `age` int NULL COMMENT 'Stores user age',
  `gender` enum('female','male','other') NULL COMMENT 'Stores gender with predefined options',
  `phone` varchar(20) NULL COMMENT 'Stores formatted phone number (e.g., 123-456-7890)',
  FOREIGN KEY (`plan_id`) REFERENCES `plans`(`plan_id`) ON DELETE SET NULL,
  CONSTRAINT `chk_age` CHECK (`age` >= 18)
) AUTO_INCREMENT= 90001;


INSERT INTO `store` (`name`, `description`, `price`, `stock`, `supplier`, `categories`, `image_url`) VALUES
-- Gym Equipment
('Adjustable Dumbbell', 'No matter how you train, our adjustable dumbbells make getting a complete workout smoother than you ever imagined. Weight: 21 kg. Dimensions: 40.5 × 19 × 17.8 cm. Set Includes: 2x 20-kg Dumbbells, 2 Cradles.', 15373.00, 100, 'JOHNSON', 'Gym Equipment', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/adjustable%20dumbell.jpg?raw=true",
 "https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/dumbell-1.jpg?raw=true",
 "https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/dumbell-2.jpg?raw=true"]}'),
 
('Adjustable Bench', 'Bring commercial-rated toughness and club-quality function to your home with our stylish Multi-adjustable Bench. Weight: 36 kg. Dimensions: 142.4 × 77.5 × 43.7 cm. Bench Height: 44cm. Backrest Adjustment Range: 5 Position Angles: 0, 30, 45, 60, 75. Seat Adjustment Range: 2 Position Angles; 0, 20.', 11999.00, 50, 'JOHNSON', 'Gym Equipment', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/adjustable-bench.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/bench-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/bench-2.jpg?raw=true"]}'),

('Horizon 3.0SC Indoor Cycle', 'If it’s hard to find time and energy for a workout, our Indoor Cycle 3.0SC can reinvigorate your senses while fitting your space, schedule and goals perfectly. Dimensions: 107 × 52 × 120 cm. Model Number: 3.0SC. Flywheel: 8 Color changing flywheel. Handlebars: Vertically Adjustable. Pedals: Self-balancing Pedals with Adjustable Straps. Seat: Ergo Seat.', 12999.00, 30, 'JOHNSON', 'Gym Equipment', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon-2.jpg?raw=true"]}'),

('Horizon EX59 Elliptical', 'The intuitive design of our EX59 Elliptical makes it easy to get started, while nine workout programs and 10 resistance levels make it hard not to come back for more. Weight: 74.5 kg. Dimensions: 186 × 61 × 167 cm. Frame: SixStar Front-drive. Stride Length: 46 cm. Flywheel: 7 kg.', 18999.00, 20, 'JOHNSON', 'Gym Equipment', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon_ex59.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon_ex59-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon_ex59-2.jpg?raw=true"]}'),

('Horizon TR5 Treadmill', 'Get a head start on your fitness journey with the TR 5.0 Treadmill. A built-in Bluetooth speaker lets you stream your favourite playlists, movies, and shows without headphones, and the electronic incline adjusts smoothly when you want to add a challenge. Weight: 59.2 kg. Dimensions: 162.5 × 77 × 139.5 cm. Running Area: 127 x 40.6 cm. Cushioning System: Variable Response Cushioning. Incline Range: 0 – 10%. Speed Range: 0.8 – 16 km/h.', 15599.00, 25, 'JOHNSON', 'Gym Equipment', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon_tr5_tread.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon_tr5-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/horizon_tr5-2.jpg?raw=true "]}'),

('Matrix FTR30 Functional Trainer', 'Already trusted in health clubs around the world, now you can get the powerful, versatile performance of a Matrix functional trainer in your home. Our incredibly smooth functional trainer lets you take on explosive athletic movements and heavy, controlled movements for a true full-body workout. Club-quality components stand up to the most intense use, and the low-height, open-frame design means our functional trainer will fit your space like it was made for it — because it was. Weight: 245 kg. Dimensions: 129.5 × 137.5 × 212 cm. Weight Stack: 136kg (Standard), 45kg (FTRHS Heavy Stack add-on). Effective Resistance: 1-Handle in Use: 1:4 Pulley Ratio: 34kg (Standard); 45kg (FTRHS Heavy Stack add-on), 2-Handles in Use: 1:2 Pulley Ratio: 68kg (Standard); 91kg (FTRHS Heavy Stack add-on). Weight Stack Guarding: Full Front and Rear Shields.', 67899.00, 10, 'JOHNSON', 'Gym Equipment', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/matrix_ftr.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/matrix_ftr30-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Equipment/matrix_ftr30-2.jpg?raw=true"]}'),

-- Gym Apparel
('Full-length Running Tights', 'Run with the wind in our Full-Length Running Tights. Constructed with improved stretch for added comfort and ease of mobility, Offer fitted support with next-to-skin comfort, Full-length, Reflective detail makes you more visible in low light conditions. Fabric Content: 100% Polyester. Wash Care: Wash at 30 degrees.', 29999.00, 200, 'MR PRICE', 'Gym Attire', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Full_length.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Full_length-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Full_length-2.jpg?raw=true"]}'),

('Dri_sport_Tshirt', 'Go for fit in our Dri-Sport t-shirt. Constructed with quick-drying Dri-Sport tech to ensure you stay cool, dry and comfy, Short sleeves, Reflective detail, Crew neck. Fabric Content: 100% Polyester.', 12999.00, 150, 'MR PRICE', 'Gym Attire', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Dri_Tshirt.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Dri_Tshirt-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Dri_Tshirt-2.jpg?raw=true"]}'),

('2-in-1 Running Shorts', 'Run wild in our double layer running shorts. Wide elasticated waistband, 2-in-1 design with built-in tights, Constructed with a slight stretch for added comfort and mobility, Zip-up pocket detail, Reflective details. Fabric Content: 100% Polyester. Wash Care: Machine wash at 30 degrees, Do not tumble dry, Air dry only.', 26999.00, 100, 'MR PRICE', 'Gym Attire', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/2-in-1%20Running%20Shorts.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/2-in-1%20Running%20Shorts-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/2-in-1%20Running Shorts-2.jpg?raw=true"]}'),

('Quarter-zip Pullover', 'Take on those chilly day training sessions with our Maxed Modest quarter-zip pullover! Longer length for added coverage. Thumbholes offer extended coverage. Quarter zip detail. Constructed with quick-drying Dri Sport tech to ensure you stay cool, dry and comfy on the move. Birdseye panels for ventilation. Fabric Content: 100% Polyester. Wash Care: Wash at 30 degrees.', 22999.00, 80, 'MR PRICE', 'Gym Attire', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Quarter-zip%20Pullover.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Quarter-zip%20Pullover-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Quarter-zip%20Pullover-2.jpg?raw=true"]}'),

('Reset Full-Length Leggings', 'Make your move and grab those goals in our Reset full-length leggings. Constructed with fitted support and next-to-skin comfort. High-waisted fit. Quick-drying fabric ensures you stay cool dry and comfortable while training. Ideal for dance, hockey & tennis. Fabric Content: 80% Nylon 20% Elastane. Wash Care: Wash at 30 degrees.', 14999.00, 120, 'MR PRICE', 'Gym Attire', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Reset%20Full-length%20Leggings.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Reset%20Full-length%20Leggings-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Reset%20Full-length%20Leggings-2.jpg?raw=true"]}'),

('Elite Compression Long Sleeve Top', 'The Maxed Elite compression range offers snug activewear for optimal performance and recovery. The tight fit reduces muscle vibration and focuses your muscle use more efficiently. Our moisture management wickable fabric draws sweat away from the skin, keeping you drier and ensuring your body temperature is stabilized in both hot and cold weather. Constructed with soft-feel, quick-drying Dri-Sport fabric to keep you cool, dry and comfortable. Fabric Content: 90% Polyester 10% Elastane. Wash Care: Wash at 30 degrees.', 32999.00, 90, 'MR PRICE', 'Gym Attire', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Elite%20Compression%20Long%20Sleeve%20Top.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Elite%20Compression%20Long%20Sleeve%20Top-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Gym-Attire/Elite%20Compression%20Long%20Sleeve%20Top-2.jpg?raw=true"]}'),

-- Fitness Trackers
('Galaxy Fit3', 'Lasts up to 13 days on a single charge. Sits lightly on your wrist, tracking over 100 workouts and daily activities, including sleep. Lets you play music, check calls and send texts right from your wrist — stay empowered, connected and effortlessly on track with Galaxy Fit3. Highlights: Up to 13 days on a single charge, 1.6" large AMOLED display, Tracking sleep and over 100 exercises, Instant notifications and media controls.', 99900.00, 50, 'SAMSUNG', 'Fitness Trackers', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-fit3.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-fit3-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-fit3-2.jpg?raw=true"]}'),

('Galaxy Watch6 (Bluetooth, 40mm)', 'Style and comfort join forces in this slimmer, sleeker shape. Galaxy Watch6 has been redesigned with a trimmed-down watch form, making it easier to wear. Size (Main Display): 1.3" (33.3mm). Body Weight (g): 28.7 g. Bluetooth Version: Bluetooth v5.3.', 499.00, 40, 'SAMSUNG', 'Fitness Trackers', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/Galaxy6.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/Galaxy6-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/Galaxy6-2.jpg?raw=true"]}'),

('Galaxy Watch4', 'Enjoy every step you take with your friends and family with the Galaxy Watch4. Track your steps and compete with friends in a fun competition through a live message board. Size (Main Display): 1.4" (34.6mm). Body Weight (g): 30.3 g. Bluetooth Version: Bluetooth v5.0.', 3599.00, 30, 'SAMSUNG', 'Fitness Trackers', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch4.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch4-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch4-2.jpg?raw=true"]}'),

('Galaxy Watch7 (Bluetooth, 44mm)', 'Elevate your style with the Galaxy Watch7. A floating glass design and colorful stitching points add a touch of elegance to your wrist, while ripples on the band show you re ready for workouts. The Watch is available in Small and Large with three color options: Green, Silver and Cream. Size (Main Display): 1.3" (33.3mm). Bluetooth Version: Bluetooth v5.3. Storage (GB): 32Gb *. Processor: 1.6GHz, 1.5GHz.', 4799.00, 20, 'SAMSUNG', 'Fitness Trackers', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch7.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch7-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch7-2.jpg?raw=true"]}'),

('Galaxy Watch FE (Bluetooth, 40mm)', 'Simply press the release button on the one-click band to detach your current watch band and attach a new one. With multiple watch bands to choose from, find the one that matches your vibe!. Size (Main Display): 1.2" (30.4mm). Bluetooth Version: Bluetooth v5.3. Storage (GB): 16GB *. Processor: 1.18GHz.', 3999.00, 15, 'SAMSUNG', 'Fitness Trackers', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch-fe.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch-fe-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/za-galaxy-watch-fe-2.jpg?raw=true"]}'),

('Samsung Gear Fit', 'This Samsung Gear Fit II SM-R360 is a great activity tracker for those who are always on the go. It features a built-in GPS and heart rate monitor, so you can track your progress and see how well you’re doing. The large strap size is perfect for those with larger wrists, and the black color looks great with any outfit. Weight: 0.2 kg. Bluetooth Version: Bluetooth v5.1. OS: FreeRTOS. Display: AMOLED. Size: 1.1" (27.8 mm). Resolution: 126 x 294. Memory: - RAM Size (MB): 2? - ROM Size (MB): 32?.', 5397.00, 10, 'SAMSUNG', 'Fitness Trackers', 
'{"images":["https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/Galaxy_Gear_Fit.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/Galaxy_Gear_Fit-1.jpg?raw=true", 
"https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/products/Fitness-Trackers/Galaxy_Gear_Fit-2.jpg?raw=true"]}');


INSERT INTO `trainers` (`name`, `email`, `specialization`, `experience`, `image_url`) VALUES 
('Johnny Bravo', 'johnny.bravo@examples.com', 'Upper Body', 5, 'https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/Trainers/T1.jpeg?raw=true'),
('Jennifer Walters', 'jennifer.walters@examples.com', 'Glutes', 3, 'https://github.com/seranger/E-commerece_Project/blob/main/frontend/public/images/Trainers/T2.jpeg?raw=true'),
('Master Roshi', 'master.roshi@example.com', 'Endurance', 30, 'https://github.com/TwinnJoe/FULL_STACK_ECCOMMECE/blob/main/public/images/Trainers/T3.jpeg?raw=true');

INSERT INTO `plan_types` (name) VALUES
('Basic'),
('Pro'),
('Premium');

INSERT INTO `plans` (`plan_id`, `type_id`, `price`, `duration_months`) VALUES
-- 12-Month Subscriptions
(51001, 50001, 750.00, '12 months'),   -- Basic
(51002, 50002, 1400.00, '12 months'),  -- Pro
(51003, 50003, 2000.00, '12 months'),  -- Premium

-- 24-Month Subscriptions
(51004, 50001, 950.00, '24 months'),   -- Basic
(51005, 50002, 1800.00, '24 months'),  -- Pro
(51006, 50003, 2500.00, '24 months'),  -- Premium

-- 36-Month Subscriptions
(51007, 50001, 1200.00, '36 months'),  -- Basic
(51008, 50002, 2200.00, '36 months'),  -- Pro
(51009, 50003, 3000.00, '36 months');  -- Premium

-- Features per plan_id (Basic)

-- Basic 12 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51001, 50001, 'Gym access'),
(51001, 50001, 'Equipment upkeep'),
(51001, 50001, 'Workout videos');

-- Basic 24 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51004, 50001, 'Gym access'),
(51004, 50001, 'Priority equipment upkeep'),
(51004, 50001, 'Extended workout videos access');

-- Basic 36 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51007, 50001, 'Gym access'),
(51007, 50001, 'Premium equipment upkeep'),
(51007, 50001, 'Workout videos, tutorials, and webinars');

-- Features per plan_id (Pro)

-- Pro 12 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51002, 50002, 'Basic perks'),
(51002, 50002, 'Group classes'),
(51002, 50002, 'Nutrition tips'),
(51002, 50002, 'Free bottle');

-- Pro 24 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51005, 50002, 'All Basic perks'),
(51005, 50002, 'Additional group classes'),
(51005, 50002, 'Advanced nutrition plans'),
(51005, 50002, 'Premium water bottle');

-- Pro 36 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51008, 50002, 'All Basic perks'),
(51008, 50002, 'Unlimited group classes'),
(51008, 50002, 'Personalized nutrition coaching'),
(51008, 50002, 'Premium gym merchandise');

-- Features per plan_id (Premium)

-- Premium 12 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51003, 50003, 'Pro perks'),
(51003, 50003, 'Health checks'),
(51003, 50003, 'Product discounts'),
(51003, 50003, 'Forum access');

-- Premium 24 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51006, 50003, 'All Pro perks'),
(51006, 50003, 'Quarterly health checks'),
(51006, 50003, 'Exclusive product discounts'),
(51006, 50003, 'VIP forum access');

-- Premium 36 months
INSERT INTO plan_features (plan_id, type_id, feature) VALUES
(51009, 50003, 'All Pro perks'),
(51009, 50003, 'Monthly health assessments'),
(51009, 50003, 'Exclusive discounts and early product releases'),
(51009, 50003, 'Private member events and VIP forum access');


INSERT INTO `users` (`name`, `email`, `password`, `address`, `plan_id`, `age`, `gender`, `phone`) VALUES 
('Jane Smith', 'janesmith@email.com', '$2b$10$a5sgLidstCkWG7f/hIOCPe89x2JVHWYW1Q.puBVCn6M5PA9qQQ5t6','123 Main St, Cityville', 51002 , 21, 'female', '123-456-7890');
