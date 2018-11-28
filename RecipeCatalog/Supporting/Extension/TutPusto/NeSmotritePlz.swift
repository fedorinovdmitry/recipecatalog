
//жеская заглушка не смотрите на этот код пожалуйста...
//TODO: Разобраться со скролвью в совокупности с тапрекогназером и УДАЛИТЬ НАХРЕН ЭТОТ КОД !!!!
extension SearchRecipeController {
    func namNeStatProgramistami() {
        beer.accessibilityValue = "10003"
        chicken.accessibilityValue = "10002"
        fish.accessibilityValue = "10021"
        luk.accessibilityValue = "10004"
        ris.accessibilityValue = "10005"
        water.accessibilityValue = "10001"
        becon.accessibilityValue = "10009"
        egg.accessibilityValue = "10011"
        slivki.accessibilityValue = "10010"
        solt.accessibilityValue = "10008"
        sosyski.accessibilityValue = "10007"
        spagetty.accessibilityValue = "10006"
        addPanGesture(view: beer)
        addPanGesture(view: chicken)
        addPanGesture(view: fish)
        addPanGesture(view: luk)
        addPanGesture(view: ris)
        addPanGesture(view: water)
        addPanGesture(view: becon)
        addPanGesture(view: slivki)
        addPanGesture(view: solt)
        addPanGesture(view: sosyski)
        addPanGesture(view: spagetty)
        addPanGesture(view: egg)
        view.bringSubviewToFront(beer)
        view.bringSubviewToFront(chicken)
        view.bringSubviewToFront(fish)
        view.bringSubviewToFront(luk)
        view.bringSubviewToFront(ris)
        view.bringSubviewToFront(water)
        view.bringSubviewToFront(becon)
        view.bringSubviewToFront(egg)
        view.bringSubviewToFront(slivki)
        view.bringSubviewToFront(solt)
        view.bringSubviewToFront(sosyski)
        view.bringSubviewToFront(spagetty)
    }
}
