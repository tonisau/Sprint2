CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    country VARCHAR(255),
    postal_code VARCHAR(20)
);
CREATE TABLE Video (
    video_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    size FLOAT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    duration TIME NOT NULL,
    thumbnail VARCHAR(255),
    views INT DEFAULT 0,
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    status ENUM('Public', 'Hidden', 'Private') NOT NULL,
    publish_datetime DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Tag (
    tag_id INT PRIMARY KEY AUTO_INCREMENT,
    tag_name VARCHAR(100) NOT NULL
);

CREATE TABLE VideoTag (
    video_id INT,
    tag_id INT,
    PRIMARY KEY (video_id, tag_id),
    FOREIGN KEY (video_id) REFERENCES Video(video_id),
    FOREIGN KEY (tag_id) REFERENCES Tag(tag_id)
);
CREATE TABLE Channel (
    channel_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    creation_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Subscription (
    user_id INT,
    channel_id INT,
    subscription_date DATETIME NOT NULL,
    PRIMARY KEY (user_id, channel_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (channel_id) REFERENCES Channel(channel_id)
);
CREATE TABLE VideoLikeDislike (
    video_id INT,
    user_id INT,
    type ENUM('Like', 'Dislike') NOT NULL,
    action_datetime DATETIME NOT NULL,
    PRIMARY KEY (video_id, user_id),
    FOREIGN KEY (video_id) REFERENCES Video(video_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE Playlist (
    playlist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    name VARCHAR(255) NOT NULL,
    creation_date DATE NOT NULL,
    status ENUM('Public', 'Private') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE PlaylistVideo (
    playlist_id INT,
    video_id INT,
    PRIMARY KEY (playlist_id, video_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id),
    FOREIGN KEY (video_id) REFERENCES Video(video_id)
);
CREATE TABLE Comment (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    video_id INT,
    user_id INT,
    text TEXT NOT NULL,
    comment_datetime DATETIME NOT NULL,
    FOREIGN KEY (video_id) REFERENCES Video(video_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
CREATE TABLE CommentLikeDislike (
    comment_id INT,
    user_id INT,
    type ENUM('Like', 'Dislike') NOT NULL,
    action_datetime DATETIME NOT NULL,
    PRIMARY KEY (comment_id, user_id),
    FOREIGN KEY (comment_id) REFERENCES Comment(comment_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
