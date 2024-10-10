

CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    user_type ENUM('Free', 'Premium') NOT NULL
);
CREATE TABLE PremiumSubscription (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    renewal_date DATE NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE CreditCard (
    credit_card_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_id INT NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    expiration_month INT NOT NULL,
    expiration_year INT NOT NULL,
    security_code VARCHAR(4) NOT NULL,
    FOREIGN KEY (subscription_id) REFERENCES PremiumSubscription(subscription_id)
);
CREATE TABLE PayPalPayment (
    paypal_payment_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_id INT NOT NULL,
    paypal_username VARCHAR(255) NOT NULL,
    FOREIGN KEY (subscription_id) REFERENCES PremiumSubscription(subscription_id)
);
CREATE TABLE PaymentHistory (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_id INT NOT NULL,
    payment_date DATE NOT NULL,
    order_number VARCHAR(100) UNIQUE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (subscription_id) REFERENCES PremiumSubscription(subscription_id)
);
CREATE TABLE Playlist (
    playlist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    song_count INT DEFAULT 0,
    creation_date DATE NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    deletion_date DATE,
    status ENUM('Active', 'Deleted') NOT NULL DEFAULT 'Active',
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Artist (
    artist_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    artist_image VARCHAR(255)
);
CREATE TABLE Album (
    album_id INT PRIMARY KEY AUTO_INCREMENT,
    artist_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    release_year YEAR NOT NULL,
    cover_image VARCHAR(255),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);
CREATE TABLE Song (
    song_id INT PRIMARY KEY AUTO_INCREMENT,
    album_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration TIME NOT NULL,
    play_count INT DEFAULT 0,
    FOREIGN KEY (album_id) REFERENCES Album(album_id)
);
CREATE TABLE SharedPlaylist (
    playlist_id INT NOT NULL,
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    added_date DATE NOT NULL,
    PRIMARY KEY (playlist_id, user_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (song_id) REFERENCES Song(song_id)
);



CREATE TABLE FavoriteSongs (
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (user_id, song_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (song_id) REFERENCES Song(song_id)
);
CREATE TABLE FavoriteAlbums (
    user_id INT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (user_id, album_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (album_id) REFERENCES Album(album_id)
);
CREATE TABLE RelatedArtists (
    artist_id INT NOT NULL,
    related_artist_id INT NOT NULL,
    PRIMARY KEY (artist_id, related_artist_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (related_artist_id) REFERENCES Artist(artist_id)
);
CREATE TABLE UserFollowsArtist (
    user_id INT NOT NULL,
    artist_id INT NOT NULL,
    PRIMARY KEY (user_id, artist_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);
