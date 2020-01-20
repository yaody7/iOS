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

func PostTodo(c *gin.Context) {
	var receive static.TodoInfo
	name := c.Param("username")
	c.BindJSON(&receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/CourseDesign?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.TodoInfo{})
	receive.Username=name
	db.Create(&receive)
	c.JSON(http.StatusOK, gin.H{
		"status":  "success",
	})
}

func GetTodo(c *gin.Context) {
	var receive static.TodoInfo
	name := c.Param("username")
	c.BindJSON(&receive)
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/CourseDesign?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.TodoInfo{})
	var todos []static.TodoInfo
	db.Where("username = ?", name).Find(&todos)
	c.JSON(http.StatusOK, gin.H{
		"items":todos,
	})
}


func DeleteTodo(c *gin.Context) {
	id := c.Param("id")
	//get dataBase
	db, err := gorm.Open("mysql", "root:root@tcp(127.0.0.1:3306)/CourseDesign?charset=utf8")
	db.SingularTable(true)
	if err != nil {
		fmt.Println(err)
	//	panic("Open DB error!")
	}
	defer db.Close()
	db.AutoMigrate(&static.TodoInfo{})

	var todo static.TodoInfo
	db.Where("id = ?", id).First(&todo)
	if todo==(static.TodoInfo{}){
		c.JSON(http.StatusOK, gin.H{
			"status": "fail",
			"err_msg": "no such todo",
		})
	}else{
		db.Delete(&todo)
		c.JSON(http.StatusOK, gin.H{
			"status": "success",
		})
	}
}