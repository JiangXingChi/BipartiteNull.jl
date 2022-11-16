using DataFrames,Graphs,Statistics

##计算每个物种的平均链接数（分类）
"""
`LinksPerSpecies(data::DataFrame)`\n
Sum of links divided by number of species(consider the overall and individual situation).\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `all`:Sum of links divided by number of all species.\n
* `agroup`:Sum of links divided by number of the species of rows.\n
* `bgroup`:Sum of links divided by number of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(6);\n
print(data);\n
all,agroup,bgroup=LinksPerSpecies(data)
"""
function LinksPerSpecies(data::DataFrame)
#  去除非数值列
  cal_data=data[:,Not(1)]
#  获取需要计算的数据尺寸
  a,b=size(cal_data)
#  计算实际连边的数量
  edge_sum=sum(sum.(eachrow(cal_data)))
#  返回总体连接平均
  all=edge_sum/(a+b)
#  返回总体连接平均
  agroup=edge_sum/a
#  返回总体连接平均
  bgroup=edge_sum/b
#  返回数值
  return(all,agroup,bgroup)
end