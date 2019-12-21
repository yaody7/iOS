package api

import (
	"hw7/static"
//	"encoding/json"
	"fmt"
	"net/http"
//	"github.com/boltdb/bolt"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/gin-gonic/gin"
)



func GetFeed(c *gin.Context) {
	tp := c.Param("tp")
	name := c.Param("username")
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/hw7?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.Article{})

	//find the top 10 articles as desc with the corresponding type
	var articles []static.Article
	if tp=="1"{
		db.Select("*").Order("type1_score desc").Limit(10).Find(&articles)
	} else if tp=="0"{
		db.Select("*").Order("ID desc").Limit(10).Find(&articles)
	}
	feedList := make([]static.ArticleForShow, 0)
	var likeinfo static.LikeInfo
	for i:= 0; i<len(articles); i++{
		var tmp static.ArticleForShow
		tmp.ID=articles[i].ID
		tmp.Title=articles[i].Title
		tmp.Image_url=articles[i].Image_url
		tmp.Author_name=articles[i].Author_name
		tmp.Content=articles[i].Content
		//get the like num
		db.Where("article_id = ?", tmp.ID).Find(&likeinfo).Count(&tmp.Liked_num)
		var tmptmp static.LikeInfo
		//check whether if the current user like
		db.Where("article_id = ? AND username = ?", tmp.ID, name).Find(&tmptmp)
		if tmptmp == (static.LikeInfo{}){
			tmp.Liked = false
		}else{
			tmp.Liked = true
		}
		feedList=append(feedList,tmp)
	 }
	c.JSON(http.StatusOK, gin.H{
		"itmes":feedList,
	})
}

func Like(c *gin.Context) {
	var receive static.LikeInfo
	c.BindJSON(&receive)
	fmt.Println(receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/hw7?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.LikeInfo{})

	//check whether the user is OK
	var user static.UserInfo
	db.Where("username = ? AND loggedin = ?", receive.Username, true).Find(&user)
	if user == (static.UserInfo{}){
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "haven't login",
		})
		return
	}

	
	//check whether if the article exists
	var exist static.Article
	db.Where("ID = ?", receive.Article_id).Find(&exist)
//	db.Where(&receive).First(&exist)
	if exist == (static.Article{}){
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "article has been deleted",
		})
	}else{
		var like static.LikeInfo
		db.Where("username = ? AND article_id = ?", receive.Username, receive.Article_id).Find(&like)
		if like == (static.LikeInfo{}){
			db.Create(&receive)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"operaion:": "like",
			})
		}else{
			db.Delete(&like)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"operaion:": "unlike",
			})
		}
	}
}


func Publish(c *gin.Context) {
	var receive static.PublishInfo
	c.BindJSON(&receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/hw7?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.Article{})

	var user static.UserInfo
	db.Where("username = ? AND loggedin = ?", receive.Author_name, true).Find(&user)
	if user == (static.UserInfo{}){
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "haven't login",
		})
		return
	}
	// make the article to publish
	var article static.Article
	article.Title = receive.Title
	article.Image_url = receive.Image_url
	article.Author_name = receive.Author_name
	article.Content = receive.Content

	db.Create(&article)
	c.JSON(http.StatusOK, gin.H{
		"status":  "success",
	})
}


