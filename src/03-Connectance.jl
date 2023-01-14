using DataFrames,Graphs,Statistics

##计算Connectance
"""
`Connectance(data::DataFrame)`\n
Realised proportion of possible links.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `value`:Connectance value.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(6);\n
print(data);\n
value=Connectance(data)
"""
function Connectance(data::DataFrame)
#  去除非数值列
  cal_data=data[:,Not(1)]
#  获取需要计算的数据尺寸
  a,b=size(cal_data)
#  计算实际连边的数量
  edge_sum=sum(sum.(eachrow(cal_data)))
#  实际连边数/可能连边数
  value=edge_sum/(a*b)
#  返回数值
  return(value)
end