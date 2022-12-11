module BipartiteNull

#  加载需要的包
using DataFrames,CSV,StatsBase,Graphs,Statistics,CategoricalArrays

#  数据处理
include("01-DataHandling.jl")
include("02-Bipartite2One.jl")
#  网络属性
include("03-Connectance.jl")
include("04-LinksPerSpecies.jl")
include("05-Cscore.jl")
include("06-GlobalClusterCoefficient.jl")
include("07-LocalClusteringCoefficient.jl")
include("08-Modularity.jl")
include("09-Centrality.jl")
#  零模型构建
include("A-Null1.jl")
include("A-Null2.jl")
#  信息整合
include("ZD-NetworkInformation.jl")

#  数据处理
export ExampleData,ReadCSV,RmZeroCol,RmZeroRow,Weight2Bool,SampleVector,Coin,CoinTest,PN1,
       Row2Edge,Col2Edge,Splicing4Matrix,Bipartite2Graph,
#  网络属性
       Connectance,
       LinksPerSpecies,
       Cscore22,Cscore,
       GlobalClusterCoefficient,GlobalClusterCoefficientQuaternion,
       LocalClusteringCoefficient,MeanLocalClusteringCoefficient,
       ModularityLabelPropagation,LabelPropagation,
       BetweennessCentrality,ClosenessCentrality,DegreeCentrality,
#  零模型构建
       Null1,
       Null2,
       Null3,
#  信息整合
       NetworkLevel,NullNetworkLevel

#  包介绍
"""
BipartiteNull.jl is a tool for building null model of bipartite network.
"""
BipartiteNull

end
