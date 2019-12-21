package static

import (
	"github.com/dgrijalva/jwt-go"
//	"github.com/jinzhu/gorm"
)

type UserInfo struct {
	Username string `json:"username" gorm:"primary_key"`
	Password string `json:"password"`
	Loggedin bool `gorm: "default:'false'"`
}

type Logout struct {
	Username string `json:"username"`
}

type Claims struct {
	Username string `json:"username"`
	Password string `json:"password"`
	jwt.StandardClaims
}


type Comment struct {
	time string
	username string
	content string
}

type Article struct {
	ID int
	Title string `json:"title"`
	Image_url string `json:"image_url"`
	Author_name string `json:"author_name"`
	Content string `json:"content"`
	Type1_score int 
}

type LikeInfo struct {
	ID int
	Article_id int `json:"article_id"`
	Username string `json:"username"`
}

type ArticleForShow struct{
	ID int
	Title string `json:"title"`
	Image_url string `json:"image_url"`
	Author_name string `json:"author_name"`
	Content string `json:"content"`
	Liked_num int `json:"liked_num" number of the like`
	Liked bool `json:"liked" whether if the current user like`
}

type PublishInfo struct {
	Title string `json:"title"`
	Image_url string `json:"image_url"`
	Author_name string `json:"author_name"`
	Content string `json:"content"`
}
