using DataFrames,CSV,StatsBase

##示例数据
"""
`ExampleData(order::Int)`\n
Some simple examples.\n
# Argument\n
* `order`:1~7.\n
# Return\n
* `data`:One dataframe.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(1)
"""
function ExampleData(order::Int)
#  检验删除0行和0列的数据
  if order==1
    data=DataFrame(AdjacencyMatrix=["A1","A2","A3","A4","A5"],
                   B1=[1,0,0,1,0],
                   B2=[1,1,1,0,0],
                   B3=[0,0,1,1,0],
                   B4=[1,0,1,0,0],
                   B5=[0,0,0,0,0],
                   B6=[1,1,1,1,0])
#  检验棋盘指数的数据
#  详见The checkerboard score and species distributions, Oecologia(1990)85:74-79
  elseif order==2
    data=DataFrame(AdjacencyMatrix=["A1","A2","A3","A4"],
                   B1=[1,1,0,0],
                   B2=[1,1,0,0],
                   B3=[0,0,1,1],
                   B4=[0,0,1,1])
#  创建1个全连接矩阵
  elseif order==3
    data=DataFrame(AdjacencyMatrix=["A1","A2","A3","A4","A5"],
                   B1=[1,1,1,1,1],
                   B2=[1,1,1,1,1],
                   B3=[1,1,1,1,1],
                   B4=[1,1,1,1,1],
                   B5=[1,1,1,1,1],
                   B6=[1,1,1,1,1])
#  创建1个全不连接矩阵
  elseif order==4
    data=DataFrame(AdjacencyMatrix=["A1","A2","A3","A4","A5"],
                   B1=[0,0,0,0,0],
                   B2=[0,0,0,0,0],
                   B3=[0,0,0,0,0],
                   B4=[0,0,0,0,0],
                   B5=[0,0,0,0,0],
                   B6=[0,0,0,0,0])
#  创建1个权重连接矩阵
  elseif order==5
    data=DataFrame(AdjacencyMatrix=["A1","A2","A3","A4","A5"],
                   B1=[0.6,0,0,0,0],
                   B2=[0,0,-0.9,0,0],
                   B3=[0.8,0,0,0,0],
                   B4=[0,0,0,-0.1,-0.2],
                   B5=[0,0.2,0,0.3,0],
                   B6=[0.6,0,-0.6,0,0])
#  创建1个投影用的矩阵
  elseif order==6
    data=DataFrame(AdjacencyMatrix=["A1","A2","A3"],
                   B1=[0,0,0],
                   B2=[0,0,1],
                   B3=[0,0,1],
                   B4=[0,1,1])
#  创建1个零模型用的矩阵
  elseif order==7
    data=DataFrame(AdjacencyMatrix=["A1","A2"],
                   B1=[1,0],
                   B2=[0,1],
                   B3=[0,1],
                   B4=[0,1],
                   B5=[1,1],
                   B6=[0,0],
                   B7=[1,0])
  end
#  返回数据
  return(data)
end

##读取csv文件并转化为dataframe
"""
`ReadCSV(file::String)`\n
Read the csv file and convert it to dataframe.\n
# Argument\n
* `file`:File name (including path).\n
# Return\n
* `data`:One dataframe.
"""
function ReadCSV(file::String)
#  其实就是dataframe的I/O方法
  data=DataFrame(CSV.File(file))
#  返回数据
  return(data)
end

##写出csv文件
"""
`WriteCSV(file::String,df::DataFrame)`\n
Write a csv file.\n
# Argument\n
* `file`:File name (including path).\n
* `df`:A dataframe.
"""
function WriteCSV(file::String,df::DataFrame)
#  其实就是dataframe的I/O方法
  CSV.write(file,df)
end

##删除全为0的列
"""
`RmZeroCol(data::DataFrame)`\n
Delete all 0 columns.\n
# Argument\n
* `data`:Adjacency matrix of a bipartite network.\n
# Return\n
* `newdata`:The columns that are all 0 are deleted on the basis of data.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(1);\n
print(data);\n
newdata=RmZeroCol(data)
"""
function RmZeroCol(data::DataFrame)
#  获取dataframe的一维二维长度
  a,b=size(data)
#  创建一个与行数长度相同的0.0向量
  zero_vector=fill(0.0,a)
#  创建一个保留序列存储
  retain_index=fill(1,1)
#  从第一列到最后一列极限循环
  for i in 2:b
#  当循环所在列与创建的零向量相等时，把此时的列数和名称组成元组tuple，推送到delnamedf中
    if data[:,i]!=zero_vector
      retain_index=vcat(retain_index,i)
    end
  end
#  保留非零向量的列
  newdata=data[:,retain_index]
#  对外界返回删除全为0列的数据框
  return(newdata)
end

##删除全为0的行
"""
`RmZeroRow(data::DataFrame)`\n
Delete all 0 rows.\n
# Argument\n
* `data`:Adjacency matrix of a bipartite network.\n
# Return\n
* `newdata`:The rows that are all 0 are deleted on the basis of data.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(1);\n
print(data);\n
newdata=RmZeroRow(data)
"""
function RmZeroRow(data::DataFrame)
#  获取dataframe的一维二维长度
  a,b=size(data)
#  创建一个与数字列数长度相同的0.0向量
  zero_vector=fill(0.0,b-1)
#  创建一个保留序列存储
  retain_index=fill(NaN,1)
#  矩阵化数据
  adjmatrix=Matrix(data[:,Not(1)])
#  从第一列到最后一列极限循环
  for i in 1:a
#  当循环所在列与创建的零向量相等时，把此时的列数和名称组成元组tuple，推送到delnamedf中
    if adjmatrix[i,:]!=zero_vector
      retain_index=vcat(retain_index,i)
    end
  end
#  保留非零向量的行，注意用Int转化浮点数为整数
  newdata=data[Int.(retain_index[2:end]),:]
#  对外界返回删除全为0列的数据框
  return(newdata)
end

##权重矩阵转为01矩阵
"""
`Weight2Bool(data::DataFrame)`\n
Convert weight values in the matrix to Boolean values.\n
# Argument\n
* `data`:Weight adjacency matrix of a bipartite network.\n
# Return\n
* `newdata`:Boolean adjacency matrix of a bipartite network.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(5);\n
print(data);\n
newdata=Weight2Bool(data)
"""
function Weight2Bool(data::DataFrame)
#  删除第1列的信息
  temp1=data[:,Not(1)]
#  对数据框中的非0数据转化为1
  temp2=ifelse.(temp1.!=0,1,temp1)
#  合并数据框
  newdata=hcat(data[:,1],temp2)
#  重现命名列名
  rename!(newdata,propertynames(data)) 
#  对外界返回数据
  return(newdata)
end

##用于零模型的抽样
"""
`SampleVector(v::Vector)`\n
Reorder.\n
# Argument\n
* `v`:Vector.\n
# Return\n
* `vnull`:New vector.\n
# Example\n
using BipartiteNull;\n
v=[1,2,3,4,5,6,7,8,9];\n
print(v);\n
vnull=SampleVector(v)
"""
function SampleVector(v::Vector)
#  获取向量长度
  length_vector=length(v)
#  生成新的向量
  vnull=StatsBase.sample(v,length_vector;replace=false)
end

##抛硬币确定true出现的概率
"""
`Coin(pvalue::Float64)`\n
Output true by probability\n
# Argument\n
* `pvalue`:Probability of true output(greater than 0 but less than 1).Please enter the value to one decimal place or two decimal places.\n
# Return\n
* `Bool`:2 values, true or false.\n
# Example\n
using BipartiteNull;\n
Coin(0.5)
"""
function Coin(pvalue::Float64)
#  根据概率确定1和0的数量
  num1=Int(100*pvalue)
  num2=Int(100-num1)
#  生成v1,v0
  v1=fill(1,num1)
  v0=fill(0,num2)
#  合并v1,v0
  v=vcat(v1,v0)
#  在v中抽取1个值，等于SigTrue的时候
  if StatsBase.sample(v,1;replace=false)==[1]
    return(true)
#  当数值为0时判定为负面，输出为false
  else
    return(false)
  end
end

##检验Coin是否有效
"""
`CoinTest(pvalue::Float64,testnumber::Int)`\n
Test Coin function.\n
# Argument\n
* `pvalue`:Probability of true output(greater than 0 but less than 1).Please enter the value to one decimal place or two decimal places.\n
* `testnumber`:Test number.
# Return\n
* `Bool`:The frequency of true is theoretically close to pvalue.\n
# Example\n
using BipartiteNull;\n
CoinTest(0.5,100000)
"""
function CoinTest(pvalue::Float64,testnumber::Int)
#  抛一次硬币
  x=Coin(pvalue)
#  抛剩下的硬币
  for i in 2:testnumber
    x=x+Coin(pvalue)
  end
#  统计true出现的频率
  turep=x/testnumber
end

"""
`PN1(v::Vector)`\n
Calculate the number of -1*1.\n
# Argument\n
* `v`:A vector.\n
# Return\n
* `c`:The number of -1*1.\n
# Example\n
v=[1,1,-1,0];\n
PN1(v)
"""
function PN1(v::Vector)
#  计算向量中等于1的元素数量
  p_number=sum(v .== 1)
#  计算向量中等于-1的元素数量
  n_number=sum(v .== -1)
#  计算-1*1的数量
  c=p_number*n_number
end