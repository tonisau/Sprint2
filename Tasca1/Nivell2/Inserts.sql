INSERT INTO User (email, password, username, birth_date, gender, country, postal_code) VALUES
('john@example.com', 'password123', 'JohnDoe', '1990-01-15', 'Male', 'USA', '10001'),
('jane@example.com', 'password456', 'JaneSmith', '1985-05-30', 'Female', 'UK', 'E1 6AN'),
('alice@example.com', 'password789', 'AliceWonder', '1995-07-12', 'Female', 'Canada', 'M5V 2T6');
INSERT INTO Channel (user_id, name, description, creation_date) VALUES
(1, 'John’s Tech Reviews', 'Tech reviews and tutorials', '2020-01-01'),
(2, 'Jane’s Cooking Channel', 'Delicious recipes and cooking tips', '2021-05-10'),
(3, 'Alice’s Travel Vlogs', 'Travel vlogs from around the world', '2022-02-15');
INSERT INTO Video (user_id, title, description, size, file_name, duration, thumbnail, views, likes, dislikes, status, publish_datetime) VALUES
(1, 'Best Laptop of 2024', 'A review of the top laptops in 2024', 500.5, 'laptop2024.mp4', '00:15:30', 'laptop_thumb.jpg', 1200, 300, 15, 'Public', '2023-10-01 10:30:00'),
(2, 'How to make lasagna', 'A step-by-step guide to making lasagna', 800.2, 'lasagna_recipe.mp4', '00:25:00', 'lasagna_thumb.jpg', 3400, 800, 20, 'Public', '2023-09-15 15:00:00'),
(3, 'Top 10 Travel Destinations in 2024', 'My top 10 travel spots for next year', 650.7, 'travel2024.mp4', '00:12:45', 'travel_thumb.jpg', 2400, 500, 30, 'Public', '2023-08-20 09:00:00');
INSERT INTO Tag (tag_name) VALUES
('Technology'),
('Cooking'),
('Travel'),
('2024');

INSERT INTO VideoTag (video_id, tag_id) VALUES
(1, 1),  -- Video 1 (Tech review) is tagged as 'Technology'
(2, 2),  -- Video 2 (Cooking lasagna) is tagged as 'Cooking'
(3, 3),  -- Video 3 (Travel destinations) is tagged as 'Travel'
(1, 4),  -- Video 1 (Tech review) is also tagged as '2024'
(3, 4);  -- Video 3 (Travel destinations) is also tagged as '2024'
INSERT INTO Subscription (user_id, channel_id, subscription_date) VALUES
(1, 2, '2023-09-01 12:00:00'),  -- John subscribes to Jane’s Cooking Channel
(2, 3, '2023-09-15 14:30:00'),  -- Jane subscribes to Alice’s Travel Vlogs
(3, 1, '2023-10-01 16:45:00');  -- Alice subscribes to John’s Tech Reviews
INSERT INTO VideoLikeDislike (video_id, user_id, type, action_datetime) VALUES
(1, 2, 'Like', '2023-10-02 12:15:00'),  -- Jane likes John's video
(2, 1, 'Like', '2023-09-20 10:00:00'),  -- John likes Jane's video
(3, 2, 'Dislike', '2023-09-25 11:45:00');  -- Jane dislikes Alice's video
INSERT INTO Playlist (user_id, name, creation_date, status) VALUES
(1, 'My Favorite Tech Videos', '2023-10-01', 'Public'),
(2, 'Best Recipes', '2023-09-18', 'Private'),
(3, 'Travel Dreams', '2023-09-30', 'Public');

INSERT INTO PlaylistVideo (playlist_id, video_id) VALUES
(1, 1),  -- John's playlist contains his tech video
(2, 2),  -- Jane's private playlist contains her recipe video
(3, 3);  -- Alice's public playlist contains her travel video
INSERT INTO Comment (video_id, user_id, text, comment_datetime) VALUES
(1, 2, 'Great review, very detailed!', '2023-10-02 12:20:00'),  -- Jane comments on John's video
(2, 1, 'Thanks for the recipe, it worked perfectly!', '2023-09-21 08:30:00'),  -- John comments on Jane's video
(3, 1, 'I want to visit all of these places!', '2023-09-25 09:45:00');  -- John comments on Alice's video
INSERT INTO CommentLikeDislike (comment_id, user_id, type, action_datetime) VALUES
(1, 1, 'Like', '2023-10-02 12:25:00'),  -- John likes Jane's comment on his video
(2, 2, 'Like', '2023-09-21 09:00:00'),  -- Jane likes John's comment on her video
(3, 3, 'Like', '2023-09-26 10:00:00');  -- Alice likes John's comment on her video
