txt="charming quick-tempered conscientious chauvinistic courageous tends to get carried away obliging sentimental affectionate intuitive stingy diligent placid over-anxious witty magnetic personality distrustful shrewd industrious shrewd extravagant down-to-earth altruistic morose sharp-tongued materialistic unstinting resolute dogged thrifty frugal immoderate obstinate parsimonious dogmatic inflexible astute pithy chatty cunning sly sullen brusque terse unscrupulous verbose garrulous "
txt2="очаровательный вспыльчивый добросовестный шовинистический смелый имеет тенденцию увлекаться услужливый сентиментальный любящий интуитивно понятный скупой прилежный спокойный чрезмерно озабоченный остроумный магнетическая личность недоверчивый проницательный трудолюбивый проницательный экстравагантный приземленный альтруистический угрюмый острый на язык материалистический неустанный решительный упорный бережливый скромный неумеренный упрямый бережливый догматический непреклонный проницательный содержательный болтливый хитрость хитрый угрюмый резкий краткий недобросовестный подробный словоохотливый"
l1=txt.split()
l2=txt2.split()
for i in range(len(l2)):
    try:
        print(l1[i], " ", l2[i])
    except IndexError:
        pass