using DataFrames,Graphs,Statistics

##计算二分网络的全局聚类系数，四元法
"""
`Cscore22(data::DataFrame)`\n
Calculate checkerboard units.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `all`:Checkerboard units/2*2 units.\n
* `agroup`:C score of the species of rows.\n
* `bgroup`:C score of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(2);\n
print(data);\n
all,agroup,bgroup=Cscore22(data)
"""
function Cscore22(data::DataFrame)
#  将数据转换为矩阵
  cal_matrix=Matrix(data[:,Not(1)])
#  获取矩阵尺寸
  a,b=size(cal_matrix)
#  获取连接可能数量
  a_link_number=a*(a-1)/2
  b_link_number=b*(b-1)/2
  unit_22=a_link_number*b_link_number
#  初始化5类四元单位的数量
  number_1001=0
  number_0110=0
#  走遍2*2矩阵，分类计算单元数量
  for i1 in 1:a-1
  for i2 in i1+1:a
    for j1 in 1:b-1
    for j2 in j1+1:b
      temp_matrix=cal_matrix[[i1,i2],[j1,j2]]
      if temp_matrix==[1 0;0 1]
        number_1001=number_1001+1
      elseif temp_matrix==[0 1;1 0]
        number_0110=number_0110+1
      end
    end
    end
  end
  end
#  计算
  all=(number_1001+number_0110)/unit_22
  agroup=(number_1001+number_0110)/a_link_number
  bgroup=(number_1001+number_0110)/b_link_number
#  返回数据
  return(all,agroup,bgroup)
end

##计算二分网络的全局聚类系数，四元法
"""
`Cscore(data::DataFrame)`\n
Calculate checkerboard units.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `all`:Checkerboard units/2*2 units.\n
* `agroup`:C score of the species of rows.\n
* `bgroup`:C score of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(2);\n
print(data);\n
all,agroup,bgroup=Cscore(data)
"""
function Cscore(data::DataFrame)
#  将数据转换为矩阵
  cal_matrix=Matrix(data[:,Not(1)])
#  获取矩阵尺寸
  a,b=size(cal_matrix)
#  获取连接可能数量
  a_link_number=a*(a-1)/2
  b_link_number=b*(b-1)/2
  unit_22=a_link_number*b_link_number
#  初始化棋盘数
  number_c=0
#  两行两行取，在此基础上计算棋盘数量
  for i1 in 1:a-1
  for i2 in i1+1:a
#  获得10和01的位置
    temp1=cal_matrix[i1,:]
    temp2=cal_matrix[i2,:]
    temp_v=temp1 .- temp2
    number_c=number_c+PN1(temp_v)
  end
  end
#  计算
  all=number_c/unit_22
  agroup=number_c/a_link_number
  bgroup=number_c/b_link_number
#  返回数据
  return(all,agroup,bgroup)
end