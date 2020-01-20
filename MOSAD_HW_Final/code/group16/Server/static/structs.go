package static

import (
//	"github.com/dgrijalva/jwt-go"
//	"github.com/jinzhu/gorm"
)

type UserInfo struct {
	Username string `json:"username" gorm:"primary_key"`
	Password string `json:"password"`
	Email string `json:"email"`
}

type LoginInfo struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type FocusInfo struct {
	Focus int `json:"focus"`
	Username string `json:"username" gorm:"primary_key"`
}

type TodoInfo struct {
	ID int	`json:"id" gorm:"primary_key"`
	Username string `json:"username"`
	Taskname string `json:"taskname"`
	Deadline string `json:"deadline"`
}

