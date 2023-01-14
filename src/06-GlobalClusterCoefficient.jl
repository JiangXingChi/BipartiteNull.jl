using DataFrames,Graphs,Statistics

##计算二分网络的全局聚类系数
"""
`GlobalClusterCoefficient(data::DataFrame)`\n
Calculate the global cluster coefficient of the bipartite network.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `agroup`:Global cluster coefficient of the species of rows.\n
* `bgroup`:Global cluster coefficient of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(6);\n
print(data);\n
agroup,bgroup=GlobalClusterCoefficient(data)
"""
function GlobalClusterCoefficient(data::DataFrame)
#  选择对二分网络邻接矩阵的转化网络模式
  omm_agroup,graph_agroup=Bipartite2Graph(data,"Col2Edge")
  omm_bgroup,graph_bgroup=Bipartite2Graph(data,"Row2Edge")
#  计算全局聚类系数
  agroup=Graphs.global_clustering_coefficient(graph_agroup)
  bgroup=Graphs.global_clustering_coefficient(graph_bgroup)
#  对外返回计算值
  return(agroup,bgroup)
end

##计算二分网络的全局聚类系数，四元法
"""
`GlobalClusterCoefficientQuaternion(data::DataFrame)`\n
Calculate the global cluster coefficient(quaternion) of the bipartite network.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `value`:Global cluster coefficient(quaternion).\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(3);\n
print(data);\n
vlaue=GlobalClusterCoefficientQuaternion(data)
"""
function GlobalClusterCoefficientQuaternion(data::DataFrame)
#  将数据转换为矩阵
  cal_matrix=Matrix(data[:,Not(1)])
#  获取矩阵尺寸
  a,b=size(cal_matrix)
#  初始化5类四元单位的数量
  number_1111=0
  number_0111=0
  number_1011=0
  number_1101=0
  number_1110=0
#  走遍2*2矩阵，分类计算单元数量
  for i1 in 1:a-1
  for i2 in i1+1:a
    for j1 in 1:b-1
    for j2 in j1+1:b
      temp_matrix=cal_matrix[[i1,i2],[j1,j2]]
      if temp_matrix==[1 1;1 1]
        number_1111=number_1111+1
      elseif temp_matrix==[0 1;1 1]
        number_0111=number_0111+1
      elseif temp_matrix==[1 0;1 1]
        number_1011=number_1011+1
      elseif temp_matrix==[1 1;0 1]
        number_1101=number_1101+1
      elseif temp_matrix==[1 1;1 0]
        number_1110=number_1110+1
      end
    end
    end
  end
  end
#  计算基于四元的全局聚类系数
  vlaue=number_1111/(number_1111+number_0111+number_1011+number_1101+number_1110)
end