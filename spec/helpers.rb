def add_nodes(graph, list)
  list.each do |node|
    graph.add_node(node, {})
  end
end

def add_edges(graph, list)
  list.each do |edge|
    graph.add_edge(*edge)
  end
end

def load_graph_from_json(graph)
  map_data = witcher_3_map_data

  map_data['points_of_interest'].each do |poi|
    graph.add_node(poi['id'], poi['properties'])
  end

  map_data['roads'].each do |road|
    graph.add_node(road['id'], road['properties'])
  end

  map_data['edges'].each do |edge|
    graph.add_edge(*edge)
  end
end

def witcher_3_map_data
  {
    "signposts" => [
      "nilfgaardian_garrison",
      "sawmill",
      "broken_bridge",
      "abandoned_village",
      "woesong_bridge",
      "mill",
      "ford",
      "crossroads",
      "cackler_bridge",
      "ransacked_village"
    ],
    "points_of_interest" => [
      {
        "id" => "nilfgaardian_garrison",
        "coordinates" => { "x" => 160, "y" => 137 },
        "properties" => {
          "signpost" => true,
          "grindstone" => true,
          "armorers_table" => true,
          "blacksmith" => true
        }
      },
      {
        "id" => "poi_01",
        "coordinates" => { "x" => 262, "y" => 165 },
        "properties" => {
          "guarded_treasure" => true
        }
      },
      {
        "id" => "poi_02",
        "coordinates" => { "x" => 296, "y" => 76 },
        "properties" => { "spoils_of_war" => true }
      },
      {
        "id" => "poi_03",
        "coordinates" => { "x" => 72, "y" => 316 },
        "properties" => { "guarded_treasure" => true }
      },
      {
        "id" => "poi_04",
        "coordinates" => { "x" => 282, "y" => 344 },
        "properties" => { "place_of_power" => true }
      },
      {
        "id" => "poi_05",
        "coordinates" => { "x" => 128, "y" => 362 },
        "properties" => { "bandit_camp" => true }
      },
      {
        "id" => "sawmill",
        "coordinates" => { "x" => 213, "y" => 496 },
        "properties" => { "signpost" => true }
      },
      {
        "id" => "poi_06",
        "coordinates" => { "x" => 269, "y" => 509 },
        "properties" => { "herbalist" => true }
      },
      {
        "id" => "poi_07",
        "coordinates" => { "x" => 143, "y" => 495 },
        "properties" => {
          "abandoned_site" => true,
          "shop_keeper" => true,
          "grindstone" => true
        }
      },
      {
        "id" => "broken_bridge",
        "coordinates" => { "x" => 394, "y" => 731 },
        "properties" => { "signpost" => true }
      },
      {
        "id" => "poi_08",
        "coordinates" => { "x" => 416, "y" => 848 },
        "properties" => { "place_of_power" => true }
      },
      {
        "id" => "poi_09",
        "coordinates" => { "x" => 331, "y" => 853 },
        "properties" => { "bandit_camp" => true }
      },
      {
        "id" => "abandoned_village",
        "coordinates" => { "x" => 538, "y" => 770 },
        "properties" => {
          "signpost" => true,
          "entrance" => true
        }
      },
      {
        "id" => "poi_10",
        "coordinates" => { "x" => 595, "y" => 732 },
        "properties" => { "entrance" => true }
      },
      {
        "id" => "poi_11",
        "coordinates" => { "x" => 685, "y" => 662 },
        "properties" => { "guarded_treasure" => true }
      },
      {
        "id" => "poi_12",
        "coordinates" => { "x" => 724, "y" => 784 },
        "properties" => { "place_of_power" => true }
      },
      {
        "id" => "poi_13",
        "coordinates" => { "x" => 746, "y" => 726 },
        "properties" => {
          "herbalist" => true,
          "abandoned_site" => true
        }
      },
      {
        "id" => "woesong_bridge",
        "coordinates" => { "x" => 587, "y" => 510 },
        "properties" => {
          "signpost" => true,
          "gwent_player" => true,
          "innkeep" => true,
          "shopkeep" => true
        }
      },
      {
        "id" => "poi_14",
        "coordinates" => { "x" => 518, "y" => 542 },
        "properties" => {
          "armorer" => true,
          "notice_board" => true,
          "grindstone" => true
        }
      },
      {
        "id" => "mill",
        "coordinates" => { "x" => 509, "y" => 312 },
        "properties" => {
          "signpost" => true
        }
      },
      {
        "id" => "poi_15",
        "coordinates" => { "x" => 485, "y" => 203 },
        "properties" => {
          "place_of_power" => true,
          "special_item" => true
        }
      },
      {
        "id" => "poi_16",
        "coordinates" => { "x" => 475, "y" => 78 },
        "properties" => {
          "place_of_power" => true,
          "monster_nest" => true
        }
      },
      {
        "id" => "poi_17",
        "coordinates" => { "x" => 470, "y" => 179 },
        "properties" => {
          "guarded_treasure" => true
        }
      },
      {
        "id" => "poi_18",
        "coordinates" => { "x" => 702, "y" => 245 },
        "properties" => {
          "hidden_treasure" => true
        }
      },
      {
        "id" => "poi_19",
        "coordinates" => { "x" => 785, "y" => 173 },
        "properties" => {
          "hidden_treasure" => true
        }
      },
      {
        "id" => "poi_20",
        "coordinates" => { "x" => 882, "y" => 207 },
        "properties" => {
          "bandit_camp" => true
        }
      },
      {
        "id" => "ford",
        "coordinates" => { "x" => 808, "y" => 539 },
        "properties" => {
          "signpost" => true
        }
      },
      {
        "id" => "poi_21",
        "coordinates" => { "x" => 780, "y" => 638 },
        "properties" => {
          "bandit_camp" => true
        }
      },
      {
        "id" => "crossroads",
        "coordinates" => { "x" => 995, "y" => 473 },
        "properties" => {
          "signpost" => true
        }
      },
      {
        "id" => "poi_22",
        "coordinates" => { "x" => 1033, "y" => 432 },
        "properties" => {
          "special_item" => true
        }
      },
      {
        "id" => "poi_23",
        "coordinates" => { "x" => 1080, "y" => 485 },
        "properties" => {
          "monster_nest" => true
        }
      },
      {
        "id" => "poi_24",
        "coordinates" => { "x" => 915, "y" => 507 },
        "properties" => {
          "bandit_camp" => true
        }
      },
      {
        "id" => "cackler_bridge",
        "coordinates" => { "x" => 945, "y" => 298 },
        "properties" => {
          "signpost" => true
        }
      },
      {
        "id" => "poi_25",
        "coordinates" => { "x" => 1025, "y" => 288 },
        "properties" => {
          "monster_nest" => true,
          "place_of_power" => true
        }
      },
      {
        "id" => "poi_26",
        "coordinates" => { "x" => 1067, "y" => 328 },
        "properties" => {
          "lootable_battlefield" => true
        }
      },
      {
        "id" => "ransacked_village",
        "coordinates" => { "x" => 1026, "y" => 598 },
        "properties" => {
          "signpost" => true
        }
      },
      {
        "id" => "poi_27",
        "coordinates" => { "x" => 1025, "y" => 664 },
        "properties" => {
          "guarded_treasure" => true
        }
      },
      {
        "id" => "poi_28",
        "coordinates" => { "x" => 926, "y" => 613 },
        "properties" => {
          "bandit_camp" => true,
          "special_item" => true
        }
      },
      {
        "id" => "poi_29",
        "coordinates" => { "x" => 845, "y" => 707 },
        "properties" => {
          "smugglers_cache" => true
        }
      },
      {
        "id" => "poi_30",
        "coordinates" => { "x" => 392, "y" => 316 },
        "properties" => {
          "hidden_treasure" => true
        }
      }
    ],
    "roads" => [
      {
          "id" => "r_01",
          "coordinates" => {
              "x" => 108,
              "y" => 166
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_02",
          "coordinates" => {
              "x" => 201,
              "y" => 96
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_03",
          "coordinates" => {
              "x" => 176,
              "y" => 286
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_04",
          "coordinates" => {
              "x" => 197,
              "y" => 357
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_05",
          "coordinates" => {
              "x" => 247,
              "y" => 393
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_06",
          "coordinates" => {
              "x" => 346,
              "y" => 378
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_07",
          "coordinates" => {
              "x" => 355,
              "y" => 332
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_08",
          "coordinates" => {
              "x" => 356,
              "y" => 297
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_09",
          "coordinates" => {
              "x" => 244,
              "y" => 463
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_10",
          "coordinates" => {
              "x" => 305,
              "y" => 550
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_11",
          "coordinates" => {
              "x" => 232,
              "y" => 577
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_12",
          "coordinates" => {
              "x" => 301,
              "y" => 613
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_13",
          "coordinates" => {
              "x" => 458,
              "y" => 511
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_14",
          "coordinates" => {
              "x" => 467,
              "y" => 558
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_15",
          "coordinates" => {
              "x" => 475,
              "y" => 604
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_16",
          "coordinates" => {
              "x" => 500,
              "y" => 580
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_17",
          "coordinates" => {
              "x" => 479,
              "y" => 642
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_18",
          "coordinates" => {
              "x" => 507,
              "y" => 634
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_19",
          "coordinates" => {
              "x" => 501,
              "y" => 674
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_20",
          "coordinates" => {
              "x" => 575,
              "y" => 591
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_21",
          "coordinates" => {
              "x" => 658,
              "y" => 519
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_22",
          "coordinates" => {
              "x" => 653,
              "y" => 488
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_23",
          "coordinates" => {
              "x" => 780,
              "y" => 501
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_24",
          "coordinates" => {
              "x" => 856,
              "y" => 678
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_25",
          "coordinates" => {
              "x" => 979,
              "y" => 654
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_26",
          "coordinates" => {
              "x" => 933,
              "y" => 560
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_27",
          "coordinates" => {
              "x" => 954,
              "y" => 574
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_28",
          "coordinates" => {
              "x" => 1057,
              "y" => 539
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_29",
          "coordinates" => {
              "x" => 1044,
              "y" => 390
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_30",
          "coordinates" => {
              "x" => 1122,
              "y" => 392
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_31",
          "coordinates" => {
              "x" => 434,
              "y" => 302
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_32",
          "coordinates" => {
              "x" => 506,
              "y" => 243
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_33",
          "coordinates" => {
              "x" => 562,
              "y" => 259
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_34",
          "coordinates" => {
              "x" => 563,
              "y" => 223
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_35",
          "coordinates" => {
              "x" => 604,
              "y" => 238
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_36",
          "coordinates" => {
              "x" => 597,
              "y" => 186
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_37",
          "coordinates" => {
              "x" => 585,
              "y" => 161
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_38",
          "coordinates" => {
              "x" => 574,
              "y" => 182
          },
          "properties" => {
              "road" => true
          }
      },
      {
          "id" => "r_39",
          "coordinates" => {
              "x" => 547,
              "y" => 172
          },
          "properties" => {
              "road" => true
          }
      }
    ],
    "edges" => [
        ["nilfgaardian_garrison", "r_01"],
        ["nilfgaardian_garrison", "r_02"],
        ["r_02", "poi_01"],
        ["r_02", "poi_02"],
        ["poi_01", "poi_02"],
        ["poi_01", "r_08"],
        ["r_08", "poi_30"],
        ["r_08", "r_07"],
        ["r_07", "poi_30"],
        ["r_07", "r_06"],
        ["r_06", "poi_04"],
        ["r_06", "r_13"],
        ["poi_04", "r_05"],
        ["poi_04", "r_04"],
        ["r_04", "poi_05"],
        ["r_04", "r_03"],
        ["poi_05", "poi_03"],
        ["poi_03", "r_03"],
        ["r_03", "r_01"],
        ["r_05", "r_09"],
        ["r_09", "sawmill"],
        ["r_09", "poi_06"],
        ["sawmill", "poi_07"],
        ["sawmill", "r_11"],
        ["r_11", "r_12"],
        ["r_11", "r_10"],
        ["r_10", "r_13"],
        ["r_13", "r_14"],
        ["r_12", "r_14"],
        ["r_14", "poi_14"],
        ["r_14", "r_15"],
        ["r_15", "r_16"],
        ["r_15", "r_17"],
        ["r_16", "poi_14"],
        ["r_16", "r_18"],
        ["r_17", "r_18"],
        ["r_17", "broken_bridge"],
        ["r_17", "r_19"],
        ["broken_bridge", "poi_09"],
        ["broken_bridge", "poi_08"],
        ["r_19", "r_18"],
        ["r_19", "abandoned_village"],
        ["r_18", "r_20"],
        ["r_20", "woesong_bridge"],
        ["woesong_bridge", "poi_14"],
        ["woesong_bridge", "r_13"],
        ["abandoned_village", "poi_10"],
        ["abandoned_village", "poi_12"],
        ["abandoned_village", "poi_13"],
        ["poi_10", "poi_11"],
        ["poi_12", "poi_13"],
        ["poi_13", "poi_11"],
        ["poi_13", "poi_29"],
        ["poi_29", "r_24"],
        ["mill", "r_22"],
        ["mill", "r_31"],
        ["mill", "r_32"],
        ["mill", "r_35"],
        ["r_32", "r_33"],
        ["r_32", "poi_15"],
        ["r_33", "r_34"],
        ["r_34", "r_35"],
        ["r_34", "r_36"],
        ["r_34", "r_38"],
        ["poi_30", "r_31"],
        ["r_38", "r_39"],
        ["r_36", "r_37"],
        ["r_37", "r_39"],
        ["r_39", "poi_17"],
        ["poi_17", "poi_16"],
        ["r_31", "poi_17"],
        ["r_35", "poi_18"],
        ["poi_18", "poi_19"],
        ["r_35", "poi_19"],
        ["poi_19", "poi_20"],
        ["cackler_bridge", "poi_20"],
        ["cackler_bridge", "poi_25"],
        ["cackler_bridge", "poi_26"],
        ["poi_25", "poi_26"],
        ["poi_26", "r_30"],
        ["r_30", "r_29"],
        ["r_29", "poi_22"],
        ["poi_22", "poi_23"],
        ["crossroads", "poi_22"],
        ["crossroads", "r_28"],
        ["crossroads", "r_27"],
        ["crossroads", "poi_24"],
        ["poi_24", "r_26"],
        ["r_26", "r_27"],
        ["r_26", "r_25"],
        ["ransacked_village", "r_27"],
        ["ransacked_village", "poi_27"],
        ["ransacked_village", "r_25"],
        ["r_25", "poi_27"],
        ["r_25", "r_24"],
        ["r_24", "poi_21"],
        ["ford", "r_23"],
        ["r_21", "r_23"],
        ["r_21", "r_22"],
        ["r_22", "cackler_bridge"],
        ["ford", "r_24"],
        ["woesong_bridge", "r_21"],
        ["ransacked_village", "r_28"],
        ["r_25", "poi_28"],
        ["poi_06", "r_10"],
        ["r_35", "r_36"],
        ["poi_08", "poi_09"],
        ["r_04", "r_05"]
    ]
  }
end
