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

func PostTime(c *gin.Context) {
	var receive static.FocusInfo
	name := c.Param("username")
	c.BindJSON(&receive)
	fmt.Println(receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/CourseDesign?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.FocusInfo{})
	
	//get the focus info
	var info static.FocusInfo
	db.Where("username = ?", name).First(&info)
	if info==(static.FocusInfo{}){
		info.Username=name
		info.Focus=receive.Focus
		db.Create(&info)
		c.JSON(http.StatusOK, gin.H{
			"status":  "success",
			"total_time": info.Focus,
		})
	}else{
		db.Delete(&info)
		info.Focus += receive.Focus
		db.Create(&info)
		c.JSON(http.StatusOK, gin.H{
			"status":  "success",
			"total_time": info.Focus,
		})
	}
}

func GetTime(c *gin.Context) {
	name := c.Param("username")
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/CourseDesign?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.FocusInfo{})

	//get the focus info
	var info static.FocusInfo
	db.Where("username = ?", name).First(&info)
	if info==(static.FocusInfo{}){
		c.JSON(http.StatusOK, gin.H{
			"total_time": 0,
		})
	}else{
		c.JSON(http.StatusOK, gin.H{
			"total_time": info.Focus,
		})
	}
}