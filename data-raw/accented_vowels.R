accented_vowels_regex <- c(
  "[AÀÁÂÃÄÅÆĀĂĄǍǞǠǢǺǼȀȂȦḀẠẢẤẦẨẪẬẮẰẲẴẶⒶＡȺⱭꜲꜴꜶꜸꜺꜼ🅰🄐🄰🅐aàáâãäåāăąǎǟǡǻȁȃȧɑḁẚạảấầẩẫậắằẳẵặ⒜ⓐａᶏᶐⱥꜳæǣꜵꜷꜹꜻꜽǽ]" = "a",
  "[EÈÉÊËĒĔĖĘĚȄȆȨḔḖḘḚḜẸẺẼẾỀỂỄỆƐⒺＥɆ🄔🄴🅔🅴eèéêëēĕėęěȅȇȩḕḗḙḛḝẹẻẽếềểễệɛᶓ⒠ⓔｅɇᶒⱸ]" = "e",
  "[IÌÍÎÏĨĪĬĮİƖƗǏȈȊḬḮỈỊⒾＩꝬ🄘🄸🅘🅸iìíîïĩīĭįǐȉȋɨɩḭḯỉịⁱ⒤ⓘｉᵼᶖꝭ]" = "i",
  "[OÒÓÔÕÖØŌŎŐƆƟƠƢǑǪǬǾȌȎȢȪȬȮȰṌṎṐṒỌỎỐỒỔỖỘỚỜỞỠỢⓄＯꝎꝊꝌ🅾🄞🄾🅞oòóôõöøōŏőơƣǒǫǭǿȍȏȣȫȭȯȱɔṍṏṑṓọỏốồổỗộớờởỡợ⒪ⓞｏᶗⱺꝏꝋꝍ]" = "o",
  "[UÙÚÛÜŨŪŬŮŰŲƯƱǓǕǗǙǛȔȖṲṴṶṸṺỤỦỨỪỬỮỰⓊＵɄ🄤🅄🅤🆄uùúûüũūŭůűųưǔǖǘǚǜȕȗʉʊᵫṳṵṷṹṻụủứừửữự⒰ⓤｕᵿᶙꝸꭐꭎꭏꭣꭒ]" = "u",
  "[WŴẀẂẄẆẈⓌＷⱲ🄦🅆🅦🆆wŵẁẃẅẇẉẘ⒲ⓦｗⱳ]" = "w",
  "[YÝŶŸƳȲẎỲỴỶỸⓎＹɎỾ🄨🅈🅨🆈yýÿŷƴȳẏẙỳỵỷỹ⒴ⓨｙɏỿꭚ]" = "y"
)

usethis::use_data(accented_vowels_regex, internal = TRUE, overwrite = TRUE)
