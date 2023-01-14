using DataFrames

##数据计算整合
"""
`NetworkLevel(data::DataFrame,ID::String)`\n
Integration of some indicators of the bipartite network.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
* `ID`:The name of the network.\n
# Return\n
* `df`:Integration of some indicators of the bipartite network.\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(7);\n
print(data);\n
df=NetworkLevel(data,"original")
"""
function NetworkLevel(data::DataFrame,ID::String)
#  设计表头
  df=DataFrame(ID=String[],Feature=String[],All=Float64[],Row_is_Vertex=Float64[],Col_is_Vertex=Float64[])
#  1-Connectance
  v1_all=Connectance(data)
  tuple1=(ID,"Connectance",v1_all,NaN,NaN)
  push!(df,tuple1)
#  2-Links per species
  v2_all,v2_agroup,v2_bgroup=LinksPerSpecies(data)
  tuple2=(ID,"Links per species",v2_all,v2_agroup,v2_bgroup)
  push!(df,tuple2)
#  3-C score
  v3_all,v3_agroup,v3_bgroup=Cscore(data)
  tuple3=(ID,"C score",v3_all,v3_agroup,v3_bgroup)
  push!(df,tuple3)
#  4-Global cluster coefficient
  v4_agroup,v4_bgroup=GlobalClusterCoefficient(data)
  tuple4=(ID,"Global cluster coefficient",NaN,v4_agroup,v4_bgroup)
  push!(df,tuple4)
#  5-Mean local clustering coefficient
  v5_agroup,v5_bgroup=MeanLocalClusteringCoefficient(data)
  tuple5=(ID,"Mean local clustering coefficient",NaN,v5_agroup,v5_bgroup)
  push!(df,tuple5)
#  6-Modularity(label propagation)
  v6_all,v6_agroup,v6_bgroup=ModularityLabelPropagation(data)
  tuple6=(ID,"Modularity(label propagation)",v6_all,v6_agroup,v6_bgroup)
  push!(df,tuple6)
#  对外返回数据
  return(df)
end

##选择一个零模型生成方式，并批量计算属性
"""
`NullNetworkLevel(data::DataFrame;num=100,fun="Null3",coinpvalue=0.5)`\n
Integration of some indicators of the bipartite network(original and null model).\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
* `num`:Generated quantity of null model.\n
* `fun`:Generation method of null model, you can select "Null1","Null2","Null3".\n
* `coinpvalue`:Probability of true output(greater than 0 but less than 1).Please enter the value to one decimal place or two decimal places.\n
# Return\n
* `df`:Integration of some indicators of the bipartite network(original and null model).\n
# Example\n
using BipartiteNull,DataFrames;\n
data=ExampleData(2);\n
print(data);\n
df=NullNetworkLevel(data)
"""
function NullNetworkLevel(data::DataFrame;num=100,fun="Null3",coinpvalue=0.5)
#  计算原始二分网络的属性
  df=NetworkLevel(data,"original")
#  生成二分网络零模型并计算，使用$进行插值
  for i in 1:num
    if fun == "Null1"
      temp_id=fun*"-"*"$i"
      temp_nulldata=Null1(data)
      temp_df=NetworkLevel(temp_nulldata,temp_id)
    elseif fun == "Null2"
      temp_id=fun*"-"*"$i"
      temp_nulldata=Null2(data,coinpvalue)
      temp_df=NetworkLevel(temp_nulldata,temp_id)
    elseif fun == "Null3"
      temp_id=fun*"-"*"$i"
      temp_nulldata=Null3(data)
      temp_df=NetworkLevel(temp_nulldata,temp_id)
    end
    df=vcat(df,temp_df)
  end
#  返回数据
  return(df)
end