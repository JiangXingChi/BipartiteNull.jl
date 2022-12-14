using DataFrames,StatsBase

##零模型3
#  思想是设定棋盘翻转
"""
`Null3(data::DataFrame)`\n
Keep the degree distribution of the original node unchanged.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `nulldata`:Dataframe generated by null model 3.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(7);\n
print(data);\n
nulldata=Null3(data)
"""
function Null3(data::DataFrame)
#  将数据转换为矩阵
  matrix_null=Matrix(data[:,Not(1)])
#  获取矩阵尺寸
  a,b=size(matrix_null)
#  走遍2*2矩阵，分类计算单元数量
  for i1 in 1:a-1
  for i2 in i1+1:a
#  获得10和01的位置
    temp1=matrix_null[i1,:]
    temp2=matrix_null[i2,:]
    temp_v=temp1 .- temp2
#  获取10和01的坐标
    old_10=findall(x-> x==1,temp_v)
    old_01=findall(x-> x==-1,temp_v)
#  确定要更换的最大棋盘数量，这里设定为10和01的数量最小值
    flip_number_max=min(length(old_10),length(old_01))
#  随机确定每两行需要更换的的棋盘数
    flip_number=StatsBase.sample(0:flip_number_max,1;replace=false)[1]
#  确定需要翻转的单位位置，利用抽样函数确定位置
    new_01=StatsBase.sample(old_10,flip_number;replace=false)
    new_10=StatsBase.sample(old_01,flip_number;replace=false)
#  进行翻转
    matrix_null[[i1,i2],new_01]=(repeat([0 1],flip_number))'
    matrix_null[[i1,i2],new_10]=(repeat([1 0],flip_number))'
  end
  end
#  转化为数据框
  nulldata=hcat(DataFrame(AdjacencyMatrix=data[:,1]),DataFrame(matrix_null,:auto))
  rename!(nulldata,propertynames(data))
#  返回数据
  return(nulldata)
end