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

func Login(c *gin.Context) {
	var receive static.UserInfo
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
			db.Delete(&user)
			user.Loggedin=true
			db.Create(&user)
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
			})
		}
	}
}

func Logout(c *gin.Context) {
	var receive static.Logout
	c.BindJSON(&receive)
	
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/hw7?charset=utf8")
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
		db.Delete(&user)
		user.Loggedin=false
		db.Create(&user)
		c.JSON(http.StatusOK, gin.H{
			"status":  "success",
		})
	}
}

func Register(c *gin.Context) {
	var receive static.UserInfo
	c.BindJSON(&receive)
	
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/hw7?charset=utf8")
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
	if duplicate==(static.UserInfo{}){
		db.Create(&receive)
		c.JSON(http.StatusOK, gin.H{
			"status":  "success",
		})
	}else{
		c.JSON(http.StatusOK, gin.H{
			"status":  "fail",
			"err_msg": "duplicate",
		})
	}
}
