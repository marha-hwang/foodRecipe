//
//  RecipeResponseDTO+Mapping.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

struct RecipeResponseDTO:Decodable{
    private enum CodingKeys: String, CodingKey {
        case COOKRCP = "COOKRCP01"
    }
    let COOKRCP:RecipeListDTO
}

extension RecipeResponseDTO{
    struct RecipeListDTO:Decodable{
        let total_count:String
        let row:[RecipeDTO]
        let RESULT:ResponseDTO
    }
}

extension RecipeResponseDTO{
    struct ResponseDTO:Decodable{
        let MSG:String
        let CODE:String
    }
}

extension RecipeResponseDTO{
    struct RecipeDTO:Decodable{
        let RCP_PARTS_DTLS:String
        let ATT_FILE_NO_MAIN:String
        let RCP_WAY2:String
        let MANUAL_IMG20:String
        let MANUAL20:String
        let RCP_SEQ:String
        let INFO_NA:String
        let INFO_WGT:String
        let INFO_PRO:String
        let INFO_FAT:String
        let HASH_TAG:String
        let RCP_PAT2:String
        let ATT_FILE_NO_MK:String
        let INFO_CAR:String
        let RCP_NM:String
        let INFO_ENG:String
        let RCP_NA_TIP:String
        let MANUAL_IMG01:String
        let MANUAL_IMG02:String
        let MANUAL_IMG03:String
        let MANUAL_IMG04:String
        let MANUAL_IMG05:String
        let MANUAL_IMG06:String
        let MANUAL_IMG07:String
        let MANUAL_IMG08:String
        let MANUAL_IMG09:String
        let MANUAL_IMG10:String
        let MANUAL_IMG11:String
        let MANUAL_IMG12:String
        let MANUAL_IMG13:String
        let MANUAL_IMG14:String
        let MANUAL_IMG15:String
        let MANUAL_IMG16:String
        let MANUAL_IMG17:String
        let MANUAL_IMG18:String
        let MANUAL_IMG19:String
        let MANUAL01:String
        let MANUAL02:String
        let MANUAL03:String
        let MANUAL04:String
        let MANUAL05:String
        let MANUAL06:String
        let MANUAL07:String
        let MANUAL08:String
        let MANUAL09:String
        let MANUAL10:String
        let MANUAL11:String
        let MANUAL12:String
        let MANUAL13:String
        let MANUAL14:String
        let MANUAL15:String
        let MANUAL16:String
        let MANUAL17:String
        let MANUAL18:String
        let MANUAL19:String
        
    }
}

extension RecipeResponseDTO{
    func toDomain(perPage:Int) -> RecipePage{
        return RecipePage(
            perPage:perPage,
            total_count: Int(COOKRCP.total_count) ?? 0,
            recpies: COOKRCP.row.map{$0.toDomain()}
        )
    }
}

extension RecipeResponseDTO.RecipeDTO{
    func toDomain() -> Recipe{
        return Recipe(
            ingredients: [],
            main_image: "https" + ATT_FILE_NO_MAIN.getString(4, ATT_FILE_NO_MAIN.count),   
            cookWay: RCP_WAY2,
            recipe_type: RCP_PAT2,
            recipe_tip: RCP_NA_TIP,
            hash_tag: HASH_TAG,
            info_wgt: INFO_WGT,
            info_na: INFO_NA,
            info_pro: INFO_PRO,
            info_fat: INFO_FAT,
            info_cal: INFO_CAR,
            info_eng: INFO_ENG,
            recipe_seq: RCP_SEQ,
            recipe_name: RCP_NM,
            manual1: MANUAL01, manual1_img: MANUAL_IMG01,
            manual2: MANUAL02, manual2_img: MANUAL_IMG02,
            manual3: MANUAL03, manual3_img: MANUAL_IMG03,
            manual4: MANUAL04, manual4_img: MANUAL_IMG04,
            manual5: MANUAL05, manual5_img: MANUAL_IMG05,
            manual6: MANUAL06, manual6_img: MANUAL_IMG06,
            manual7: MANUAL07, manual7_img: MANUAL_IMG07,
            manual8: MANUAL08, manual8_img: MANUAL_IMG08,
            manual9: MANUAL09, manual9_img: MANUAL_IMG09,
            manual10: MANUAL10, manual10_img: MANUAL_IMG10,
            manual11: MANUAL11, manual11_img: MANUAL_IMG11,
            manual12: MANUAL12, manual12_img: MANUAL_IMG12,
            manual13: MANUAL13, manual13_img: MANUAL_IMG13,
            manual14: MANUAL14, manual14_img: MANUAL_IMG14,
            manual15: MANUAL15, manual15_img: MANUAL_IMG15,
            manual16: MANUAL16, manual16_img: MANUAL_IMG16,
            manual17: MANUAL17, manual17_img: MANUAL_IMG17,
            manual18: MANUAL18, manual18_img: MANUAL_IMG18,
            manual19: MANUAL19, manual19_img: MANUAL_IMG19,
            manual20: MANUAL20, manual20_img: MANUAL_IMG20)
        
    }
}
