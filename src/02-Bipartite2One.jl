using DataFrames,Graphs

##投影法，行类群转为边
"""
`Row2Edge(data::DataFrame)`\n
Convert nodes represented by rows to edges.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `newdata`:One-mode network after projection.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(6);\n
print(data);\n
newdata=Row2Edge(data)
"""
function Row2Edge(data::DataFrame)
#  删除0向量的行，得到可以投影的边
  exist_edge=RmZeroRow(data)
#  可以投影的边数量  
  edge_number=size(exist_edge,1)
#  获取成员名称
  bname=names(exist_edge[:,Not(1)])
  bpname=propertynames(exist_edge[:,Not(1)])
#  获取成员数量
  bnumber=length(bname)
#  创建投影的单模矩阵
  adjmatrix=fill(0,(bnumber,bnumber))
#  创建物种索引
  bindex=DataFrame(Index=1:bnumber,ID=bname)
#  1级循环，从头开始处理每一个边
  for i in 1:edge_number
#  首先得到可投影边的第i个边，然后用RmZeroCol删除0向量的列，再获取可以通过该边连接的点
    temp_link_member=names(RmZeroCol(exist_edge[[i],:]))[2:end]
#  用in函数从bindex中提取存在可连接点的信息
    temp_bindex=bindex[in.(bindex.ID,Ref(temp_link_member)),:]
#  获取可连接点的数量
    temp_bnumber=size(temp_bindex,1)
#  利用两个循环嵌套，完成对投影的单模矩阵的填充，并且该填充是对称的
    for j in 1:temp_bnumber-1
      for k in j+1:temp_bnumber
        adj_x=temp_bindex.Index[j]
        adj_y=temp_bindex.Index[k]
        adjmatrix[adj_x,adj_y]=1
        adjmatrix[adj_y,adj_x]=1
      end
    end
  end
#  对数据进行包装
  newdata=hcat(DataFrame(RowEdge=bname),DataFrame(adjmatrix,bpname))
#  对外界返回数据
  return(newdata)
end

##投影法，列类群转为边
"""
`Col2Edge(data::DataFrame)`\n
Convert nodes represented by columns to edges.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `newdata`:One-mode network after projection.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(6);\n
print(data);\n
newdata=Col2Edge(data)
"""
function Col2Edge(data::DataFrame)
#  删除0向量的列
  exist_edge=RmZeroCol(data)
#  可以投影的边数量  
  edge_number=size(exist_edge,2)-1
#  获取成员名称
  aname=exist_edge[:,1]
  apname=Symbol.(aname)
#  获取成员数量
  anumber=length(aname)
#  创建投影的单模矩阵
  adjmatrix=fill(0,(anumber,anumber))
#  创建物种索引
  aindex=DataFrame(Index=1:anumber,ID=aname)
#  1级循环，从头开始处理每一个边
  for i in 1:edge_number
#  首先得到可投影边的第i个边，然后用RmZeroRow删除0向量的行，再获取可以通过该边连接的点
    temp_link_member=RmZeroRow(exist_edge[:,[1,i+1]])[:,1]
#  用in函数从aindex中提取存在可连接点的信息
    temp_aindex=aindex[in.(aindex.ID,Ref(temp_link_member)),:]
#  获取可连接点的数量
    temp_anumber=size(temp_aindex,1)
#  利用两个循环嵌套，完成对投影的单模矩阵的填充，并且该填充是对称的
    for j in 1:temp_anumber-1
      for k in j+1:temp_anumber
        adj_x=temp_aindex.Index[j]
        adj_y=temp_aindex.Index[k]
        adjmatrix[adj_x,adj_y]=1
        adjmatrix[adj_y,adj_x]=1
      end
    end
  end
#  对数据进行包装
  newdata=hcat(DataFrame(ColEdge=aname),DataFrame(adjmatrix,apname))
#  对外界返回数据
  return(newdata)
end

##拼接法转单模
"""
`Splicing4Matrix(data::DataFrame)`\n
The bipartite network is expanded into a one-mode network through matrix splicing.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `newdata`:One-mode network after splicing.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(6);\n
print(data);\n
newdata=Splicing4Matrix(data)
"""
function Splicing4Matrix(data::DataFrame)
#  获取行成员数量，名称
  anumber=size(data,1)
  aname=data[:,1]
#  获取列成员数量，名称
  bnumber=size(data,2)-1
  bname=names(data)[2:end]
#  获取总体成员数量，名称
  allnumber=anumber+bnumber
  allname=vcat(aname,bname)
  allpname=Symbol.(allname)
#  创建4矩阵
  leftup=fill(0,(anumber,anumber))
  rightup=Matrix(data[:,Not(1)])
  leftdown=rightup'
  rightdown=fill(0,(bnumber,bnumber))
#  拼接矩阵
  up=hcat(leftup,rightup)
  down=hcat(leftdown,rightdown)
  adjmatrix=vcat(up,down)
#  整合数据框
  newdata=hcat(DataFrame(Splicing=allname),DataFrame(adjmatrix,allpname))
#  返回数据
  return(newdata)
end

##将二分网络的邻接矩阵转化为Graphs的
"""
`Bipartite2Graph(data::DataFrame,model::String)`\n
Convert the adjacency matrix of the bipartite network into the network structure under Graphs.jl through projection or expansion.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
* `fun`:Select the conversion method and support three functions:"Row2Edge","Col2Edge","Splicing4Matrix".\n
# Return\n
* `omm`:One-mode matrix by projection or expansion.\n
* `graph`:The network structure under Graphs.jl.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(6);\n
print(data);\n
omm,graph=Bipartite2Graph(data,"Row2Edge")
"""
function Bipartite2Graph(data::DataFrame,fun::String)
#  选择对二分网络邻接矩阵的操作模式
  if fun=="Row2Edge"
    newdata=Row2Edge(data)
  elseif fun=="Col2Edge"
    newdata=Col2Edge(data)
  elseif fun=="Splicing4Matrix"
    newdata=Splicing4Matrix(data)
  end
#  将投影或者扩充后的数据转化为矩阵
  omm=Matrix(newdata[:,Not(1)])
#  利用矩阵构建网络
  graph=Graphs.SimpleGraph(omm)
#  对外返回网络
  return(omm,graph)
end