package main

import (
	"fmt"
	"net/http"
	"backend/api"
	"github.com/gin-gonic/gin"
)

func Init() {
	router := gin.Default()
	fmt.Println("router init")
	be_api := router.Group("/api")
	{
		be_api.GET("/test", func(c *gin.Context) {
			fmt.Println("test...")
			c.JSON(200, gin.H{
				"msg": "OK!",
			})
		})
		be_api.POST("/register", api.Register)
		be_api.POST("/login", api.Login)
		be_api.POST("/user/:username/focus", api.PostTime)
		be_api.GET("/user/:username/focus", api.GetTime)
		be_api.POST("/user/:username/todo", api.PostTodo)
		be_api.GET("/user/:username/todo",api.GetTodo)
		be_api.GET("/deleteTodo/ID/:id", api.DeleteTodo)
	}

	router.NoRoute(func(c *gin.Context) {
		fmt.Println("enter noroute")
		c.JSON(http.StatusNotFound, gin.H{
			"status": 404,
			"error":  "你来到了没有知识的荒野",
		})
	})

	router.Run(":8001")
}

func main() {
	Init()
}
