$version: "2.0"

namespace common

document JSONSchema

document Any

/// 国际化文本，格式为 {"en": "English", "zh-CN": "中文"}
map I18nText {
    key: String
    value: String
}

enum Language {
    ENGLISH = "english"
    CHINESE = "chinese"
    JAPANESE = "japanese"
    ARABIC = "arabic"
    FILIPINO = "filipino"
    FRENCH = "french"
    GERMAN = "german"
    INDONESIAN = "indonesian"
    ITALIAN = "italian"
    MALAY = "malay"
    PORTUGUESE = "portuguese"
    RUSSIAN = "russian"
    AFRIKAANS = "afrikaans"
    SPANISH = "spanish"
    THAI = "thai"
    TURKISH = "turkish"
    VIETNAMESE = "vietnamese"
    MULTILINGUAL = "multilingual"
}

enum LanguageCode {
    /// Cantonese
    CHINESE_YUE= "yue"
    ENGLISH = "eng"
    AFRIKAANS = "afr"
    SPANISH = "spa"
    ARABIC = "ara"
    FRENCH = "fra"
    GERMAN = "deu"  
    RUSSIAN = "rus"
    /// Mandarin
    CHINESE_MANDARIN = "cmn"
    PORTUGUESE = "por"
    JAPANESE = "jpn"
    /// Min Nan
    CHINESE_MINNAN = "nan"
    FILIPINO = "fil"
    INDONESIAN = "ind"
    ITALIAN = "ita"
    THAI = "tha"
    OTHER = "other" 
    MALAY = "msa"
    VIETNAMESE = "vie"
    TURKISH = "tur"
}
