# @author Anatoly Mironov (mirontoli)
# http://sharepointkunskap.wordpress.com
# http://www.bool.se
#
# http://stackoverflow.com/questions/3605495/generate-a-list-of-localized-language-names-with-links-to-google-translate/14800384#14800384
# http://stackoverflow.com/questions/10997128/language-name-from-iso-639-1-code-in-javascript/14800499#14800499
#
# using Phil Teare's answer on stackoverflow
# http://stackoverflow.com/questions/3217492/list-of-language-codes-in-yaml-or-json/4900304#4900304
# Just for testing only. Incorporate in your own javascript namespace
# Example: getLanguageName("cv-RU") --> Chuvash

isoLangs =
    "ab":{
        "name":"Abkhaz",
        "nativeName":"аҧсуа"
    },
    "aa":{
        "name":"Afar",
        "nativeName":"Afaraf"
    },
    "af":{
        "name":"Afrikaans",
        "nativeName":"Afrikaans"
    },
    "ak":{
        "name":"Akan",
        "nativeName":"Akan"
    },
    "sq":{
        "name":"Albanian",
        "nativeName":"Shqip"
    },
    "am":{
        "name":"Amharic",
        "nativeName":"አማርኛ"
    },
    "ar":{
        "name":"Arabic",
        "nativeName":"العربية"
    },
    "an":{
        "name":"Aragonese",
        "nativeName":"Aragonés"
    },
    "hy":{
        "name":"Armenian",
        "nativeName":"Հայերեն"
    },
    "as":{
        "name":"Assamese",
        "nativeName":"অসমীয়া"
    },
    "av":{
        "name":"Avaric",
        "nativeName":"авар мацӀ, магӀарул мацӀ"
    },
    "ae":{
        "name":"Avestan",
        "nativeName":"avesta"
    },
    "ay":{
        "name":"Aymara",
        "nativeName":"aymar aru"
    },
    "az":{
        "name":"Azerbaijani",
        "nativeName":"azərbaycan dili"
    },
    "bm":{
        "name":"Bambara",
        "nativeName":"bamanankan"
    },
    "ba":{
        "name":"Bashkir",
        "nativeName":"башҡорт теле"
    },
    "eu":{
        "name":"Basque",
        "nativeName":"euskara, euskera"
    },
    "be":{
        "name":"Belarusian",
        "nativeName":"Беларуская"
    },
    "bn":{
        "name":"Bengali",
        "nativeName":"বাংলা"
    },
    "bh":{
        "name":"Bihari",
        "nativeName":"भोजपुरी"
    },
    "bi":{
        "name":"Bislama",
        "nativeName":"Bislama"
    },
    "bs":{
        "name":"Bosnian",
        "nativeName":"bosanski jezik"
    },
    "br":{
        "name":"Breton",
        "nativeName":"brezhoneg"
    },
    "bg":{
        "name":"Bulgarian",
        "nativeName":"български език"
    },
    "my":{
        "name":"Burmese",
        "nativeName":"ဗမာစာ"
    },
    "ca":{
        "name":"Catalan; Valencian",
        "nativeName":"Català"
    },
    "ch":{
        "name":"Chamorro",
        "nativeName":"Chamoru"
    },
    "ce":{
        "name":"Chechen",
        "nativeName":"нохчийн мотт"
    },
    "ny":{
        "name":"Chichewa; Chewa; Nyanja",
        "nativeName":"chiCheŵa, chinyanja"
    },
    "zh":{
        "name":"Chinese",
        "nativeName":"中文 (Zhōngwén), 汉语, 漢語"
    },
    "cv":{
        "name":"Chuvash",
        "nativeName":"чӑваш чӗлхи"
    },
    "kw":{
        "name":"Cornish",
        "nativeName":"Kernewek"
    },
    "co":{
        "name":"Corsican",
        "nativeName":"corsu, lingua corsa"
    },
    "cr":{
        "name":"Cree",
        "nativeName":"ᓀᐦᐃᔭᐍᐏᐣ"
    },
    "hr":{
        "name":"Croatian",
        "nativeName":"hrvatski"
    },
    "cs":{
        "name":"Czech",
        "nativeName":"česky, čeština"
    },
    "da":{
        "name":"Danish",
        "nativeName":"dansk"
    },
    "dv":{
        "name":"Divehi; Dhivehi; Maldivian;",
        "nativeName":"ދިވެހި"
    },
    "nl":{
        "name":"Dutch",
        "nativeName":"Nederlands, Vlaams"
    },
    "en":{
        "name":"English",
        "nativeName":"English"
    },
    "eo":{
        "name":"Esperanto",
        "nativeName":"Esperanto"
    },
    "et":{
        "name":"Estonian",
        "nativeName":"eesti, eesti keel"
    },
    "ee":{
        "name":"Ewe",
        "nativeName":"Eʋegbe"
    },
    "fo":{
        "name":"Faroese",
        "nativeName":"føroyskt"
    },
    "fj":{
        "name":"Fijian",
        "nativeName":"vosa Vakaviti"
    },
    "fi":{
        "name":"Finnish",
        "nativeName":"suomi, suomen kieli"
    },
    "fr":{
        "name":"French",
        "nativeName":"français, langue française"
    },
    "ff":{
        "name":"Fula; Fulah; Pulaar; Pular",
        "nativeName":"Fulfulde, Pulaar, Pular"
    },
    "gl":{
        "name":"Galician",
        "nativeName":"Galego"
    },
    "ka":{
        "name":"Georgian",
        "nativeName":"ქართული"
    },
    "de":{
        "name":"German",
        "nativeName":"Deutsch"
    },
    "el":{
        "name":"Greek, Modern",
        "nativeName":"Ελληνικά"
    },
    "gn":{
        "name":"Guaraní",
        "nativeName":"Avañeẽ"
    },
    "gu":{
        "name":"Gujarati",
        "nativeName":"ગુજરાતી"
    },
    "ht":{
        "name":"Haitian; Haitian Creole",
        "nativeName":"Kreyòl ayisyen"
    },
    "ha":{
        "name":"Hausa",
        "nativeName":"Hausa, هَوُسَ"
    },
    "he":{
        "name":"Hebrew (modern)",
        "nativeName":"עברית"
    },
    "hz":{
        "name":"Herero",
        "nativeName":"Otjiherero"
    },
    "hi":{
        "name":"Hindi",
        "nativeName":"हिन्दी, हिंदी"
    },
    "ho":{
        "name":"Hiri Motu",
        "nativeName":"Hiri Motu"
    },
    "hu":{
        "name":"Hungarian",
        "nativeName":"Magyar"
    },
    "ia":{
        "name":"Interlingua",
        "nativeName":"Interlingua"
    },
    "id":{
        "name":"Indonesian",
        "nativeName":"Bahasa Indonesia"
    },
    "ie":{
        "name":"Interlingue",
        "nativeName":"Originally called Occidental; then Interlingue after WWII"
    },
    "ga":{
        "name":"Irish",
        "nativeName":"Gaeilge"
    },
    "ig":{
        "name":"Igbo",
        "nativeName":"Asụsụ Igbo"
    },
    "ik":{
        "name":"Inupiaq",
        "nativeName":"Iñupiaq, Iñupiatun"
    },
    "io":{
        "name":"Ido",
        "nativeName":"Ido"
    },
    "is":{
        "name":"Icelandic",
        "nativeName":"Íslenska"
    },
    "it":{
        "name":"Italian",
        "nativeName":"Italiano"
    },
    "iu":{
        "name":"Inuktitut",
        "nativeName":"ᐃᓄᒃᑎᑐᑦ"
    },
    "ja":{
        "name":"Japanese",
        "nativeName":"日本語 (にほんご／にっぽんご)"
    },
    "jv":{
        "name":"Javanese",
        "nativeName":"basa Jawa"
    },
    "kl":{
        "name":"Kalaallisut, Greenlandic",
        "nativeName":"kalaallisut, kalaallit oqaasii"
    },
    "kn":{
        "name":"Kannada",
        "nativeName":"ಕನ್ನಡ"
    },
    "kr":{
        "name":"Kanuri",
        "nativeName":"Kanuri"
    },
    "ks":{
        "name":"Kashmiri",
        "nativeName":"कश्मीरी, كشميري‎"
    },
    "kk":{
        "name":"Kazakh",
        "nativeName":"Қазақ тілі"
    },
    "km":{
        "name":"Khmer",
        "nativeName":"ភាសាខ្មែរ"
    },
    "ki":{
        "name":"Kikuyu, Gikuyu",
        "nativeName":"Gĩkũyũ"
    },
    "rw":{
        "name":"Kinyarwanda",
        "nativeName":"Ikinyarwanda"
    },
    "ky":{
        "name":"Kirghiz, Kyrgyz",
        "nativeName":"кыргыз тили"
    },
    "kv":{
        "name":"Komi",
        "nativeName":"коми кыв"
    },
    "kg":{
        "name":"Kongo",
        "nativeName":"KiKongo"
    },
    "ko":{
        "name":"Korean",
        "nativeName":"한국어 (韓國語), 조선말 (朝鮮語)"
    },
    "ku":{
        "name":"Kurdish",
        "nativeName":"Kurdî, كوردی‎"
    },
    "kj":{
        "name":"Kwanyama, Kuanyama",
        "nativeName":"Kuanyama"
    },
    "la":{
        "name":"Latin",
        "nativeName":"latine, lingua latina"
    },
    "lb":{
        "name":"Luxembourgish, Letzeburgesch",
        "nativeName":"Lëtzebuergesch"
    },
    "lg":{
        "name":"Luganda",
        "nativeName":"Luganda"
    },
    "li":{
        "name":"Limburgish, Limburgan, Limburger",
        "nativeName":"Limburgs"
    },
    "ln":{
        "name":"Lingala",
        "nativeName":"Lingála"
    },
    "lo":{
        "name":"Lao",
        "nativeName":"ພາສາລາວ"
    },
    "lt":{
        "name":"Lithuanian",
        "nativeName":"lietuvių kalba"
    },
    "lu":{
        "name":"Luba-Katanga",
        "nativeName":""
    },
    "lv":{
        "name":"Latvian",
        "nativeName":"latviešu valoda"
    },
    "gv":{
        "name":"Manx",
        "nativeName":"Gaelg, Gailck"
    },
    "mk":{
        "name":"Macedonian",
        "nativeName":"македонски јазик"
    },
    "mg":{
        "name":"Malagasy",
        "nativeName":"Malagasy fiteny"
    },
    "ms":{
        "name":"Malay",
        "nativeName":"bahasa Melayu, بهاس ملايو‎"
    },
    "ml":{
        "name":"Malayalam",
        "nativeName":"മലയാളം"
    },
    "mt":{
        "name":"Maltese",
        "nativeName":"Malti"
    },
    "mi":{
        "name":"Māori",
        "nativeName":"te reo Māori"
    },
    "mr":{
        "name":"Marathi (Marāṭhī)",
        "nativeName":"मराठी"
    },
    "mh":{
        "name":"Marshallese",
        "nativeName":"Kajin M̧ajeļ"
    },
    "mn":{
        "name":"Mongolian",
        "nativeName":"монгол"
    },
    "na":{
        "name":"Nauru",
        "nativeName":"Ekakairũ Naoero"
    },
    "nv":{
        "name":"Navajo, Navaho",
        "nativeName":"Diné bizaad, Dinékʼehǰí"
    },
    "nb":{
        "name":"Norwegian Bokmål",
        "nativeName":"Norsk bokmål"
    },
    "nd":{
        "name":"North Ndebele",
        "nativeName":"isiNdebele"
    },
    "ne":{
        "name":"Nepali",
        "nativeName":"नेपाली"
    },
    "ng":{
        "name":"Ndonga",
        "nativeName":"Owambo"
    },
    "nn":{
        "name":"Norwegian Nynorsk",
        "nativeName":"Norsk nynorsk"
    },
    "no":{
        "name":"Norwegian",
        "nativeName":"Norsk"
    },
    "ii":{
        "name":"Nuosu",
        "nativeName":"ꆈꌠ꒿ Nuosuhxop"
    },
    "nr":{
        "name":"South Ndebele",
        "nativeName":"isiNdebele"
    },
    "oc":{
        "name":"Occitan",
        "nativeName":"Occitan"
    },
    "oj":{
        "name":"Ojibwe, Ojibwa",
        "nativeName":"ᐊᓂᔑᓈᐯᒧᐎᓐ"
    },
    "cu":{
        "name":"Old Church Slavonic, Church Slavic, Church Slavonic," +
               " Old Bulgarian, Old Slavonic",
        "nativeName":"ѩзыкъ словѣньскъ"
    },
    "om":{
        "name":"Oromo",
        "nativeName":"Afaan Oromoo"
    },
    "or":{
        "name":"Oriya",
        "nativeName":"ଓଡ଼ିଆ"
    },
    "os":{
        "name":"Ossetian, Ossetic",
        "nativeName":"ирон æвзаг"
    },
    "pa":{
        "name":"Panjabi, Punjabi",
        "nativeName":"ਪੰਜਾਬੀ, پنجابی‎"
    },
    "pi":{
        "name":"Pāli",
        "nativeName":"पाऴि"
    },
    "fa":{
        "name":"Persian",
        "nativeName":"فارسی"
    },
    "pl":{
        "name":"Polish",
        "nativeName":"polski"
    },
    "ps":{
        "name":"Pashto, Pushto",
        "nativeName":"پښتو"
    },
    "pt":{
        "name":"Portuguese",
        "nativeName":"Português"
    },
    "qu":{
        "name":"Quechua",
        "nativeName":"Runa Simi, Kichwa"
    },
    "rm":{
        "name":"Romansh",
        "nativeName":"rumantsch grischun"
    },
    "rn":{
        "name":"Kirundi",
        "nativeName":"kiRundi"
    },
    "ro":{
        "name":"Romanian, Moldavian, Moldovan",
        "nativeName":"română"
    },
    "ru":{
        "name":"Russian",
        "nativeName":"русский язык"
    },
    "sa":{
        "name":"Sanskrit (Saṁskṛta)",
        "nativeName":"संस्कृतम्"
    },
    "sc":{
        "name":"Sardinian",
        "nativeName":"sardu"
    },
    "sd":{
        "name":"Sindhi",
        "nativeName":"सिन्धी, سنڌي، سندھی‎"
    },
    "se":{
        "name":"Northern Sami",
        "nativeName":"Davvisámegiella"
    },
    "sm":{
        "name":"Samoan",
        "nativeName":"gagana faa Samoa"
    },
    "sg":{
        "name":"Sango",
        "nativeName":"yângâ tî sängö"
    },
    "sr":{
        "name":"Serbian",
        "nativeName":"српски језик"
    },
    "gd":{
        "name":"Scottish Gaelic; Gaelic",
        "nativeName":"Gàidhlig"
    },
    "sn":{
        "name":"Shona",
        "nativeName":"chiShona"
    },
    "si":{
        "name":"Sinhala, Sinhalese",
        "nativeName":"සිංහල"
    },
    "sk":{
        "name":"Slovak",
        "nativeName":"slovenčina"
    },
    "sl":{
        "name":"Slovene",
        "nativeName":"slovenščina"
    },
    "so":{
        "name":"Somali",
        "nativeName":"Soomaaliga, af Soomaali"
    },
    "st":{
        "name":"Southern Sotho",
        "nativeName":"Sesotho"
    },
    "es":{
        "name":"Spanish; Castilian",
        "nativeName":"español, castellano"
    },
    "su":{
        "name":"Sundanese",
        "nativeName":"Basa Sunda"
    },
    "sw":{
        "name":"Swahili",
        "nativeName":"Kiswahili"
    },
    "ss":{
        "name":"Swati",
        "nativeName":"SiSwati"
    },
    "sv":{
        "name":"Swedish",
        "nativeName":"svenska"
    },
    "ta":{
        "name":"Tamil",
        "nativeName":"தமிழ்"
    },
    "te":{
        "name":"Telugu",
        "nativeName":"తెలుగు"
    },
    "tg":{
        "name":"Tajik",
        "nativeName":"тоҷикӣ, toğikī, تاجیکی‎"
    },
    "th":{
        "name":"Thai",
        "nativeName":"ไทย"
    },
    "ti":{
        "name":"Tigrinya",
        "nativeName":"ትግርኛ"
    },
    "bo":{
        "name":"Tibetan Standard, Tibetan, Central",
        "nativeName":"བོད་ཡིག"
    },
    "tk":{
        "name":"Turkmen",
        "nativeName":"Türkmen, Түркмен"
    },
    "tl":{
        "name":"Tagalog",
        "nativeName":"Wikang Tagalog, ᜏᜒᜃᜅ᜔ ᜆᜄᜎᜓᜄ᜔"
    },
    "tn":{
        "name":"Tswana",
        "nativeName":"Setswana"
    },
    "to":{
        "name":"Tonga (Tonga Islands)",
        "nativeName":"faka Tonga"
    },
    "tr":{
        "name":"Turkish",
        "nativeName":"Türkçe"
    },
    "ts":{
        "name":"Tsonga",
        "nativeName":"Xitsonga"
    },
    "tt":{
        "name":"Tatar",
        "nativeName":"татарча, tatarça, تاتارچا‎"
    },
    "tw":{
        "name":"Twi",
        "nativeName":"Twi"
    },
    "ty":{
        "name":"Tahitian",
        "nativeName":"Reo Tahiti"
    },
    "ug":{
        "name":"Uighur, Uyghur",
        "nativeName":"Uyƣurqə, ئۇيغۇرچە‎"
    },
    "uk":{
        "name":"Ukrainian",
        "nativeName":"українська"
    },
    "ur":{
        "name":"Urdu",
        "nativeName":"اردو"
    },
    "uz":{
        "name":"Uzbek",
        "nativeName":"zbek, Ўзбек, أۇزبېك‎"
    },
    "ve":{
        "name":"Venda",
        "nativeName":"Tshivenḓa"
    },
    "vi":{
        "name":"Vietnamese",
        "nativeName":"Tiếng Việt"
    },
    "vo":{
        "name":"Volapük",
        "nativeName":"Volapük"
    },
    "wa":{
        "name":"Walloon",
        "nativeName":"Walon"
    },
    "cy":{
        "name":"Welsh",
        "nativeName":"Cymraeg"
    },
    "wo":{
        "name":"Wolof",
        "nativeName":"Wollof"
    },
    "fy":{
        "name":"Western Frisian",
        "nativeName":"Frysk"
    },
    "xh":{
        "name":"Xhosa",
        "nativeName":"isiXhosa"
    },
    "yi":{
        "name":"Yiddish",
        "nativeName":"ייִדיש"
    },
    "yo":{
        "name":"Yoruba",
        "nativeName":"Yorùbá"
    },
    "za":{
        "name":"Zhuang, Chuang",
        "nativeName":"Saɯ cueŋƅ, Saw cuengh"
    }

@getLanguageName = (key) ->
    key = key.slice(0,2)
    lang = isoLangs[key]
    if lang then lang.name else undefined

@getLanguageNativeName = (key) ->
    key = key.slice(0,2)
    lang = isoLangs[key]
    if lang then lang.nativeName else undefined

@getCanonicalNativeName = (key) ->
    langName = getLanguageNativeName(key)
    if langName?
        commaIndex = langName.indexOf(',')
        semiColonIndex = langName.indexOf(';')

        firstLangIdx  = if commaIndex != -1 then commaIndex else semiColonIndex

        if firstLangIdx != -1
            langName.slice(0, firstLangIdx)
        else
            langName
    else
        undefined

# This data can be fetched at runtime by making calls to the API, but I do not
# expect the support to change at a very rapid pace. Also, the google codes
# for Chinese language work in Bing but not vice versa.
bingSupportedLanguages = [
        { code:'ar'       , name: 'Arabic'              } ,
        { code:'bg'       , name: 'Bulgarian'           } ,
        { code:'ca'       , name: 'Catalan'             } ,
        # { code:'zh-CHS'   , name: 'Chinese Simplified'  } ,
        # { code:'zh-CHT'   , name: 'Chinese Traditional' } ,
        { code:'zh-CN'    , name: 'Chinese Simplified'  } ,
        { code:'zh-TW'    , name: 'Chinese Traditional' } ,

        { code:'cs'       , name: 'Czech'               } ,
        { code:'da'       , name: 'Danish'              } ,
        { code:'nl'       , name: 'Dutch'               } ,
        { code:'en'       , name: 'English'             } ,
        { code:'et'       , name: 'Estonian'            } ,
        { code:'fi'       , name: 'Finnish'             } ,
        { code:'fr'       , name: 'French'              } ,
        { code:'de'       , name: 'German'              } ,
        { code:'el'       , name: 'Greek'               } ,
        { code:'ht'       , name: 'Haitian Creole'      } ,
        { code:'he'       , name: 'Hebrew'              } ,
        { code:'hi'       , name: 'Hindi'               } ,
        { code:'mww'      , name: 'Hmong Daw'           } ,
        { code:'hu'       , name: 'Hungarian'           } ,
        { code:'id'       , name: 'Indonesian'          } ,
        { code:'it'       , name: 'Italian'             } ,
        { code:'ja'       , name: 'Japanese'            } ,
        { code:'tlh'      , name: 'Klingon'             } ,
        { code:'tlh-Qaak' , name: 'Klingon (pIqaD)'     } ,
        { code:'ko'       , name: 'Korean'              } ,
        { code:'lv'       , name: 'Latvian'             } ,
        { code:'lt'       , name: 'Lithuanian'          } ,
        { code:'ms'       , name: 'Malay'               } ,
        { code:'mt'       , name: 'Maltese'             } ,
        { code:'no'       , name: 'Norwegian'           } ,
        { code:'fa'       , name: 'Persian'             } ,
        { code:'pl'       , name: 'Polish'              } ,
        { code:'pt'       , name: 'Portuguese'          } ,
        { code:'ro'       , name: 'Romanian'            } ,
        { code:'ru'       , name: 'Russian'             } ,
        { code:'sk'       , name: 'Slovak'              } ,
        { code:'sl'       , name: 'Slovenian'           } ,
        { code:'es'       , name: 'Spanish'             } ,
        { code:'sv'       , name: 'Swedish'             } ,
        { code:'th'       , name: 'Thai'                } ,
        { code:'tr'       , name: 'Turkish'             } ,
        { code:'uk'       , name: 'Ukrainian'           } ,
        { code:'ur'       , name: 'Urdu'                } ,
        { code:'vi'       , name: 'Vietnamese'          } ,
        { code:'cy'       , name: 'Welsh'               }
    ]

# This data can be fetched at runtime by making calls to the API, but I do not
# expect the support to change at a very rapid pace.
googleSupportedLanguages = [
        { name: 'Afrikaans'           , code: 'af' }    ,
        { name: 'Albanian'            , code: 'sq' }    ,
        { name: 'Arabic'              , code: 'ar' }    ,
        { name: 'Azerbaijani'         , code: 'az' }    ,
        { name: 'Basque'              , code: 'eu' }    ,
        { name: 'Bengali'             , code: 'bn' }    ,
        { name: 'Belarusian'          , code: 'be' }    ,
        { name: 'Bulgarian'           , code: 'bg' }    ,
        { name: 'Catalan'             , code: 'ca' }    ,
        { name: 'Chinese Simplified'  , code: 'zh-CN' } ,
        { name: 'Chinese Traditional' , code: 'zh-TW' } ,
        { name: 'Croatian'            , code: 'hr' }    ,
        { name: 'Czech'               , code: 'cs' }    ,
        { name: 'Danish'              , code: 'da' }    ,
        { name: 'Dutch'               , code: 'nl' }    ,
        { name: 'English'             , code: 'en' }    ,
        { name: 'Esperanto'           , code: 'eo' }    ,
        { name: 'Estonian'            , code: 'et' }    ,
        { name: 'Filipino'            , code: 'tl' }    ,
        { name: 'Finnish'             , code: 'fi' }    ,
        { name: 'French'              , code: 'fr' }    ,
        { name: 'Galician'            , code: 'gl' }    ,
        { name: 'Georgian'            , code: 'ka' }    ,
        { name: 'German'              , code: 'de' }    ,
        { name: 'Greek'               , code: 'el' }    ,
        { name: 'Gujarati'            , code: 'gu' }    ,
        { name: 'Haitian Creole'      , code: 'ht' }    ,
        # Here, I think, Bing's choice of code is better and more conforming.
        # { name: 'Hebrew'              , code: 'iw' }    ,
        { name: 'Hebrew'              , code: 'he' }    ,
        { name: 'Hindi'               , code: 'hi' }    ,
        { name: 'Hungarian'           , code: 'hu' }    ,
        { name: 'Icelandic'           , code: 'is' }    ,
        { name: 'Indonesian'          , code: 'id' }    ,
        { name: 'Irish'               , code: 'ga' }    ,
        { name: 'Italian'             , code: 'it' }    ,
        { name: 'Japanese'            , code: 'ja' }    ,
        { name: 'Kannada'             , code: 'kn' }    ,
        { name: 'Korean'              , code: 'ko' }    ,
        { name: 'Latin'               , code: 'la' }    ,
        { name: 'Latvian'             , code: 'lv' }    ,
        { name: 'Lithuanian'          , code: 'lt' }    ,
        { name: 'Macedonian'          , code: 'mk' }    ,
        { name: 'Malay'               , code: 'ms' }    ,
        { name: 'Maltese'             , code: 'mt' }    ,
        { name: 'Norwegian'           , code: 'no' }    ,
        { name: 'Persian'             , code: 'fa' }    ,
        { name: 'Polish'              , code: 'pl' }    ,
        { name: 'Portuguese'          , code: 'pt' }    ,
        { name: 'Romanian'            , code: 'ro' }    ,
        { name: 'Russian'             , code: 'ru' }    ,
        { name: 'Serbian'             , code: 'sr' }    ,
        { name: 'Slovak'              , code: 'sk' }    ,
        { name: 'Slovenian'           , code: 'sl' }    ,
        { name: 'Spanish'             , code: 'es' }    ,
        { name: 'Swahili'             , code: 'sw' }    ,
        { name: 'Swedish'             , code: 'sv' }    ,
        { name: 'Tamil'               , code: 'ta' }    ,
        { name: 'Telugu'              , code: 'te' }    ,
        { name: 'Thai'                , code: 'th' }    ,
        { name: 'Turkish'             , code: 'tr' }    ,
        { name: 'Ukrainian'           , code: 'uk' }    ,
        { name: 'Urdu'                , code: 'ur' }    ,
        { name: 'Vietnamese'          , code: 'vi' }    ,
        { name: 'Welsh'               , code: 'cy' }    ,
        { name: 'Yiddish'             , code: 'yi' }
    ]


# Using the "name" of the language as the primary key to identify the
# languages
getCombinedLangDict = ->
    combinedLangDict = {}

    googleSupportedLanguages.forEach (googLang) ->
        if not combinedLangDict[googLang.name]?
            combinedLangDict[googLang.name] = {}

        _.extend(combinedLangDict[googLang.name], { googleCode: googLang.code })


    bingSupportedLanguages.forEach (bingLang) ->
        if not combinedLangDict[bingLang.name]?
            combinedLangDict[bingLang.name] = {}

        _.extend(combinedLangDict[bingLang.name], { bingCode: bingLang.code })

    combinedLangDict

@supportedLangs = _.pairs(getCombinedLangDict())
                    .filter((kv) -> kv[1].googleCode? && kv[1].bingCode?)
                    .map((kv) -> { name: kv[0], code: kv[1].googleCode })
