package api

import (
	"backend/static"
//	"encoding/json"
	"fmt"
	"net/http"
//	"github.com/boltdb/bolt"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/gin-gonic/gin"
)

func Login(c *gin.Context) {
	var receive static.UserInfo
	c.BindJSON(&receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/CourseDesign?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.UserInfo{})

	//get the userinfo
	var user static.UserInfo
	db.Where("username = ?", receive.Username).First(&user)
	//check whether the user exist
	if user==(static.UserInfo{}){
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "no such user",
		})
	}else{
		//check whether the password is correct
		if user.Password != receive.Password{
			c.JSON(http.StatusOK, gin.H{
				"status":  "fail",
				"err_msg": "wrong username or password",
			})
		}else{
			db.AutoMigrate(&static.TodoInfo{})
			var count int
			db.Model(&static.TodoInfo{}).Where("username = ?", receive.Username).Count(&count)
			db.AutoMigrate(&static.FocusInfo{})

			var focus static.FocusInfo
			db.Where("username = ?", receive.Username).First(&focus)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"email": user.Email,
				"focus_time": focus.Focus,
				"todo_num": count,
			})
		}
	}
}

func Register(c *gin.Context) {
	var receive static.UserInfo
	c.BindJSON(&receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/CourseDesign?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.UserInfo{})

	//check whether if duplicate
	var duplicate static.UserInfo
	db.Where(&receive).First(&duplicate)
	db.Where("username = ? OR email = ?", receive.Username, receive.Email).First(&duplicate)
	if duplicate==(static.UserInfo{}){
		db.Create(&receive)
		c.JSON(http.StatusOK, gin.H{
			"status":  "success",
		})
	}else{
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "your username or email is duplicate",
		})
	}
}
