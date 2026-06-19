# 淘宝用户行为数据分析

基于 MySQL 对淘宝用户购物行为数据集进行分析，涵盖数据预处理、用户获取指标计算和用户留存率分析。

## 数据集

- **来源**：[天池数据集 - 淘宝用户购物行为数据集](https://tianchi.aliyun.com/dataset/649)
- **数据字段**：
  | 字段名 | 说明 |
  |--------|------|
  | user_id | 用户 ID |
  | item_id | 商品 ID |
  | category_id | 商品类目 ID |
  | behavior_type | 行为类型（pv/buy/cart/fav）|
  | timestamps | 行为时间戳 |
- **数据时间范围**：2017-11-25 至 2017-12-03

## 分析内容

### 1. 数据预处理 (`taobao.sql`)
- 建表与数据导入
- 缺失值与重复值检测
- 数据去重处理
- 时间戳转换为日期时间格式
- 异常值处理

### 2. 用户获取分析 (`Customer Acquisition Performance.sql`)
- **PV（Page View）**：页面浏览量
- **UV（Unique Visitor）**：独立访客数
- **PV/UV**：浏览深度（人均浏览页面数）

### 3. 用户留存分析 (`Retention Performance.sql`)
- **次日留存率**：次日回访用户占比
- **跳失率**：仅访问一次即离开的用户比例

## 环境要求

- MySQL 5.7+
- Navicat 或其他 MySQL 客户端（可选）

## 使用方法

1. 下载数据集并解压 `UserBehavior.csv`
2. 执行 `taobao.sql` 完成建表和数据导入
3. 依次执行其他 SQL 文件进行分析

> **注意**：修改 `taobao.sql` 中的 `LOAD DATA LOCAL INFILE` 路径为你本地 CSV 文件的实际路径。
