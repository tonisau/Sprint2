INSERT INTO User (email, password, username, birth_date, gender, country, postal_code, user_type) VALUES
('john@example.com', 'password123', 'JohnDoe', '1990-01-15', 'Male', 'USA', '10001', 'Premium'),
('jane@example.com', 'password456', 'JaneSmith', '1985-05-30', 'Female', 'UK', 'E1 6AN', 'Free');
INSERT INTO PremiumSubscription (user_id, start_date, renewal_date, payment_method) VALUES
(1, '2023-01-01', '2024-01-01', 'Credit Card');
INSERT INTO CreditCard (subscription_id, card_number, expiration_month, expiration_year, security_code) VALUES
(1, '1234567890123456', 12, 2025, '123');
INSERT INTO PaymentHistory (subscription_id, payment_date, order_number, total) VALUES
(1, '2023-01-01', 'ORD123456', 9.99);
INSERT INTO Playlist (user_id, title, song_count, creation_date, status) VALUES
(1, 'John\'s Playlist', 10, '2023-06-01', 'Active'),
(2, 'Jane\'s Chill Mix', 5, '2023-08-01', 'Active');
INSERT INTO Artist (name, artist_image) VALUES
('Artist A', 'artistA.jpg'),
('Artist B', 'artistB.jpg');
INSERT INTO Album (artist_id, title, release_year, cover_image) VALUES
(1, 'Album One', 2023, 'cover1.jpg'),
(1, 'Album Two', 2021, 'cover2.jpg');
INSERT INTO Song (album_id, title, duration, play_count) VALUES
(1, 'Song A', '03:45', 100),
(1, 'Song B', '04:10', 200);
INSERT INTO SharedPlaylist (playlist_id, user_id, song_id, added_date) VALUES
(1, 1, 1, '2023-06-02'),
(1, 1, 2, '2023-06-02');

INSERT INTO FavoriteSongs (user_id, song_id) VALUES
(1, 1),
(1, 2);
INSERT INTO FavoriteAlbums (user_id, album_id) VALUES
(1, 1);

INSERT INTO RelatedArtists (artist_id, related_artist_id) VALUES
(1, 2);
INSERT INTO UserFollowsArtist (user_id, artist_id) VALUES
(1, 1);
