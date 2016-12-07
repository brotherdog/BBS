CREATE TABLE Authority
(
    id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(8)
);
CREATE TABLE User_Group
(
    id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(8) NOT NULL,
    acc_point_min INT(11) NOT NULL
);
CREATE TABLE Users
(
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    name VARCHAR(10),
    password VARCHAR(16) NOT NULL,
    sex VARCHAR(2) DEFAULT '男' NOT NULL,
    email VARCHAR(30),
    phone VARCHAR(11),
    acc_point INT(11) DEFAULT '0',
    group_id INT(11),
    authority_id INT(11),
    CONSTRAINT Users_User_Group_id_fk FOREIGN KEY (group_id) REFERENCES User_Group (id),
    CONSTRAINT Users_Authority_id_fk FOREIGN KEY (authority_id) REFERENCES Authority (id)
);
CREATE INDEX Users_Authority_id_fk ON Users (authority_id);
CREATE INDEX Users_User_Group_id_fk ON Users (group_id);
CREATE TABLE Layout
(
    id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    info VARCHAR(4000),
    group_id INT(11) NOT NULL,
    CONSTRAINT Layout_User_Group_id_fk FOREIGN KEY (group_id) REFERENCES User_Group (id)
);
CREATE INDEX Layout_User_Group_id_fk ON Layout (group_id);
CREATE TABLE Post
(
    id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(40) NOT NULL,
    content VARCHAR(4000),
    create_date DATETIME,
    user_id VARCHAR(11),
    layout_id INT(11),
    CONSTRAINT Post_Users_id_fk FOREIGN KEY (user_id) REFERENCES Users (id),
    CONSTRAINT Post_Layout_id_fk FOREIGN KEY (layout_id) REFERENCES Layout (id)
);
CREATE INDEX Post_Layout_id_fk ON Post (layout_id);
CREATE INDEX Post_Users_id_fk ON Post (user_id);
CREATE TABLE Moderator
(
    user_id VARCHAR(11) NOT NULL,
    layout_id INT(11) NOT NULL,
    CONSTRAINT `PRIMARY` PRIMARY KEY (user_id, layout_id),
    CONSTRAINT Moderator_Users_id_fk FOREIGN KEY (user_id) REFERENCES Users (id),
    CONSTRAINT Moderator_Layout_id_fk FOREIGN KEY (layout_id) REFERENCES Layout (id)
);
CREATE INDEX Moderator_Layout_id_fk ON Moderator (layout_id);
CREATE TABLE Comment
(
    id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    content VARCHAR(4000) NOT NULL,
    create_date DATETIME,
    post_id INT(11),
    create_user_id VARCHAR(10),
    CONSTRAINT Comment_Post_id_fk FOREIGN KEY (post_id) REFERENCES Post (id),
    CONSTRAINT Comment_Users_id_fk FOREIGN KEY (create_user_id) REFERENCES Users (id)
);
CREATE INDEX Comment_Post_id_fk ON Comment (post_id);
CREATE INDEX Comment_Users_id_fk ON Comment (create_user_id);

CREATE TRIGGER Auto_Time_Post
  BEFORE INSERT ON Post
  FOR EACH ROW
  BEGIN
    SET new.create_date = now();
  END;

CREATE TRIGGER Auto_Time_Comment
  BEFORE INSERT ON Comment
  FOR EACH ROW
  BEGIN
    SET new.create_date = now();
  END;