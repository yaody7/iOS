# API 设计文档

> API_v1，实现了用户注册、登陆、登出，以及文章点赞及获取feed流的功能。需要补充的是评论的功能，由于本次作业与课程设计并行，而课程作业是小组作业，所以选择割舍这边的时间去配合团队成员，所以做得比较仓促，在之后会将加分项也完成好。

#### 用户注册

`post:/api/register`

**Request**

```
{
	"username":"<username gotten>",
	"password":"<password gotten>"
}
```

**Response**

- 成功

```
{
	"status":"success"
}
```

- 失败

```
{
	"status":"fail",
	"err_msg":"<error message>"
}
```



#### 用户登录

`POST:/api/login`

**Request**

```
{
	"username":"<username gotten>",
	"password":"<password gotten>"
}
```

**Response**

- 成功

```
{
	"status:":"success"
}
```

- 失败

```
{
	"status":"fail",
	"err_msg":"<error message>"
}
```



#### 用户登出

`POST:/api/logout`

**Request**

```
{
	"username":"<username gotten>"
}
```

**Response**

- 成功

```
{
	"status:":"success"
}
```

- 失败

```
{
	"status":"fail"
	"err_msg":"<error message>"
}
```



#### 获得文章

`GET:/api/type/:tp/user/:username/getFeed`

**注：** type为用户喜欢的类型文章，未登录用户type设为0即可；username为用户名，未登录用户名设为0即可

**Response**

```
{
	"items":{
		{
			ID:{article_id},
			title:{title},
			image_url:{image_url},
			author_name:{author_name},
			content:{content}
			liked_num:{liked_num}
			liked:{true/false}
		},
		{
			.....
		}
	}
}
```



#### 点赞/取消赞

`POST:/api/like/user/:userID/article/:articleID`

**Response**

- 成功（点赞）

```
{
	"status":"success"
	"operation":"like"
}
```

- 成功（取消赞）

``` 
{
	"status":"success"
	"operation":"unlike"
}
```

- 失败

```
{
	"status":"fail",
	"err_msg":"<error message>"
}
```



#### 发布文章

`POST:/api/publish`

**Request**

```
{
	"title":{title}
	"image_url":{image_url}
	"author_name":{author_name}
	"content":{content}
}
```

**Response**

- 成功

```
{
	"status":  "success"
}
```

- 失败

```
{
	"status":  "fail",
	"err_msg": "haven't login"
}
```





