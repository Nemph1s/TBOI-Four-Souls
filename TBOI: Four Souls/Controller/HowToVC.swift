//
//  HowToVC.swift
//  TBOI: Four Souls
//
//  Created by  Volodymyr Martyniuk on 9/26/18.
//  Copyright © 2018 VMart. All rights reserved.
//

import UIKit
import FSPagerView

class HowToVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    fileprivate let pageData = [
        ["The Basics"
            , "2-4 Players take turns playing Loot cards and using Items to kill Monsters in order to gain more Items, Loot cards and sometimes Souls. The first player to gain 4 souls is the winner. Co-operation, bartering and betrayal are all strongly encouraged."],
        ["Starting the Game", "The Monster, Loot and Treasure decks are each shuffled and placed apart on the table.\n\n2 Monster cards are revealed and placed face up next to the Monster deck. These are the current active Monsters. If any non-Monster cards are revealed this way, place them at the bottom of the deck and continue this process until 2 Monster cards are revealed.\n\n2 Treasure Items are revealed and placed face up next to the Treasure deck. These are the current Store Items.\n\nShuffle the Character deck and deal out one Character card to all players face down. Each player then reveals their Character and gains their Starting Item.\n\nAll players start with their Character card activated (turned sideways).\n\nEach player starts the game with 3 loot cards and 3¢\n\nCain always plays first. If Cain is not one of the characters drawn, then the saddest person playing goes first, or just roll a dice, whatever works…"],
        ["Player turn:", "1. Recharge all active Items and your Player card - Turn all Items and Player cards upright.\n2. Loot 1 - Draw the top card from the Loot deck and put it in your hand.\n3. Action Phase:\nDuring their Action Phase, the active player may do any or all of the following in any order:\n• Play 1 Loot card - This can be in response to any action.\n• Purchase 1 Store Item or topmost card of the Treasure deck - All Store Items cost 10¢, including the topmost card of the deck.\n• Attack a Monster - The player can choose to attack any active Monster or attack the   topmost card of the Monster deck.\n• Activate their Player card to play an additional Loot card - Player cards can also be saved and activated on other players’ turns in response to any action.\n4. Ending Phase\nHeal all Players and Monsters.\nDiscard down to 10 Loot cards if you have more than 10 in your hand.\nPass the turn to the player to your left."],
        ["Loot Cards", "Loot cards are the only cards you draw and keep in your hand. Playing them can instantly change the flow of the game in many interesting ways.\n\nLoot Card Types:\n\nBasic Loot - Basic Loot cards come in the form of coins, bombs, hearts, pills and the like, and are used to gain resources or aid in combat.\n\nTarot cards - Tarot cards are more advanced Loot cards that can drastically change the course of the game in many neato ways.\n\nTrinkets - These are rare Loot cards. When played, these act like Treasure Items and have passive effects. Place these cards face up on the table next to your Item cards. They count as Items when in play."],
        ["Monster Cards", "The Monster deck is the meat and potatoes of the game. It’s filled with basic Monsters, Bosses, Treasures, Curses and other surprises.\n\nBasic Monsters - Monsters that are easier to kill and yield Loot, Coins and on rare occasions, Treasures.\n\nBosses - Difficult-to-kill Monsters with bigger rewards that always yield souls when killed. When a Boss is killed, the player gains that Boss card, this is how you keep track of souls.\n\nBonus Cards - Uncommon cards that yield rewards... but may also kill you…\n\nCurses - Rare cards that curse a player of the revealers choosing. Curse cards are placed to the left of your Character card and are discarded when the cursed player dies."],
        ["Treasure Cards", "Treasure cards are Items that players gain. Treasure cards are put directly into play in front of the player, are visible to everyone and tend to have very strong effects that modify gameplay and interact with other players and Monsters.\n\nActive Items - These Items can be activated in response to any action. These are marked with a gold border and turning arrow symbol. Once an Item has been activated, it can't be activated again till it’s recharged at the start of that player’s turn. You show an Item has been activated by turning it sideways.\n\nPassive Items - These Items give players special abilities that usually change the rules of the game or modify existing effects. These abilities don't require activation. Passive Items have silver borders.\n\nPaid Items - These Items are used when you pay a specific cost. These are marked with a $ symbol. Like active Items, paid Items can be used in response to any action, but paid items can be used as many times as they are paid for and aren't turned sideways when used."],
        ["Combat", "Players may attack once during their turn.\n\nIf a player decides to attack, they can target an active Monster card or the topmost card of the Monster deck. If they attack the topmost card of the deck, they have to reveal that Monster card to all players and place it face up over one of the active Monsters.\n\nWhen a player attacks a Monster card they roll their D6. If the number is equal or greater to that Monster’s dice number and that dice roll “resolves” (no one uses any abilities to modify or reroll the result), the player deals damage equal to their damage number to that Monster. If the player rolls lower than the Monster’s dice number, they miss and take damage equal to that Monster’s damage number. The attacking player continues until either the Monster or player is killed.\n\nUse the D8 to keep track of the damage done to a Monster during that turn.\n\nWhen a Monster is killed, the active player gains rewards for its death and that Monster card is placed face up on the top of the Monster deck discard pile. If the active Monster is killed and an active Monster slot is empty, reveal the top card of the Monster deck and place it face up in that empty slot.\n\nIf a Monster deals lethal damage to a player, that player is killed (see: Death). That player pays a penalty and it ends their turn.\n\nAll damage done to players and Monster cards are healed at the end of any player’s turn.\n\nNote - If a non-Monster card is revealed when a player attacks the top card of the Monster deck or is revealed when adding a card to an empty active Monster slot, the active player reads that card to all players and follows the directions on the card. If a non-Monster was revealed when attacking the topmost card of the Monster deck, this will count as your attack for the turn."],
        ["Death", "When a player takes lethal damage or is killed for any reason, that player suffers \\“The Death Penalty!\\”. This means that they must destroy a non-eternal Item they control, discard a Loot card and lose 1¢.\n\nIn addition to the penalty, that player also de-activates all their Items and Player card, marking the end of their turn."],
        ["Multiple item or loot interaction  (aka: stacking effects)", "When a player makes an action (activating an item, interacting with a deck, attacking a monster, playing a loot card, rolling a dice, etc.) any other player can respond to this action by activating one of their items, or using their Character card to play a loot card in response.\n\nWhen multiple effects like this trigger at once, you wait to see if everyone is done responding to the action. Then each effect plays out in reverse order, so the last effect resolves first and 2nd to last goes next until each effect is resolved ending with the initial player’s action.\n\nExample 1: Player 1 decides to attack an active Monster that needs a 4 or higher dice roll to deal damage. Player 1 rolls their dice to see if a hit lands and they roll a 3. In response to this roll, Player 2 offers to raise the roll by 1 with their Book of Belial in exchange for 2¢. Player 1 agrees, pays them and Player 2 activates the Book of Belial to raise the roll to a 4. Out of nowhere, Player 3 decides to activate their D6 in response, forcing Player 1 to reroll the dice! No one else has any response to this, so each effect now plays out in reverse. Player 3 rerolls the dice, and rolls a 1, Player 2 adds +1 to that dice making it a 2, then the dice resolves, making Player 1 miss, seeing as they needed a 4+ in order to land that attack.\n\nExample 2: Player 1 activates their Tarot Deck Item to Loot 1. In response, Player 2 uses their Sleight of Hand Item to look at the top 3 cards of the Loot deck and put them back in any order. No other effects are played. Player 2 looks at the top 3 cards, rearranges them so a single penny card is placed on the top. Then Player 1’s Loot 1 effect goes off, drawing them a single penny… :(.\n\nStacking effects is where advanced strategy really shines, so make sure you read your Loot cards and Item effects carefully. Most are designed specifically to be used in many different ways."],
        ["The Bonus Souls", "Once players have a better understanding of the game’s mechanics, you are encouraged to add the Bonus Souls (the Soul of Guppy, the Soul of Greed and the Soul of Gluttony) to your games. These bonus cards aren’t added to any deck but Instead lay face up on the table next to the game decks in view of all the players.\n\nThe first player to gain 25¢ or more instantly gains the Soul of Greed.\n\nThe first player to have 10 or more Loot cards in their hand instantly gains the Soul of Gluttony The first player to have 2 or more Guppy Items in their possession, instantly gains the Soul of Guppy.\n\nEach soul can only be gained once per game."],
        ["Credits", "Lead Design & Art Direction - Edmund McMillen\nAdditional Design & Production - Danielle McMillen\nAdditional Design - Tyler Glaiel\nLayout/Background Art & Illustration - @TikaraTheMew\nCard Back Design/Box art & Illustration - @KrystalFlamingo\nFigure Design & Illustration @Rojen241,\nIllustration - @Wormchild and @Tar_Head\nBusiness Development (Studio71) – Javon Frazier and Garima Sharma\n\nTesters - Jackson Moore,Tyler Glaiel, Danielle McMillen, George Fan, Eli Evans, Acacia Evans, Jay Lewis, Graeme Little, Leon Masters, Dan Zaelit, Cole O’Brien, Doug O’Brien, Crystal Evans, Joe Evans, Alex Austin, Caitlyn Yantis, Peach McMillen."]] as [[String]]
    
    fileprivate let imageData = ["", "", "", "image4", "image2", "image3", "image1", "", "", "image5", ""]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.delegate = self
        pagerView.dataSource = self
    }
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- FSPagerViewDataSource
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.pageData.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let contentView = cell.contentView
        clearPagerViewCell(cell)
        
        let scrollView = createScrollView()
        contentView.addSubview(scrollView)
    
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
        
        // add labelOne to the scroll view
        let labelTitle = createTitleLabel()
        scrollView.addSubview(labelTitle)
        labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0).isActive = true
        labelTitle.text = pageData[index][0]
        
        var bottomAnchor: NSLayoutYAxisAnchor = labelTitle.bottomAnchor
        var bottomAnchorConstant: CGFloat = 16.0
        
        let imageName = imageData[index]
        if !imageName.isEmpty {
            
            let isLandscapeImage = imageName.contains("image1")
            let spacer: CGFloat = 50
            let imageWidth: CGFloat = isLandscapeImage ? 382 : 200
            let imageHeight: CGFloat = isLandscapeImage ? 200 : 273

            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            imageView.frame.size.width = imageWidth
            imageView.frame.size.height = imageHeight
            
            imageView.frame.origin.y = spacer
            scrollView.addSubview(imageView)
            
            bottomAnchor = imageView.bottomAnchor
            bottomAnchorConstant = 0
        }
        
        let labelDescription = createDescriptionLabel()
        scrollView.addSubview(labelDescription)
        labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        labelDescription.topAnchor.constraint(equalTo: bottomAnchor, constant: bottomAnchorConstant).isActive = true
        labelDescription.text = pageData[index][1]
        /*
        let imageName = imageData[index]
        if !imageName.isEmpty {
            
            let imageWidth:CGFloat = 200
            let imageHeight:CGFloat = 273
            var yPosition: CGFloat = 0
            var scrollViewHeight: CGFloat = scrollView.contentSize.height
            let scrollViewWidth: CGFloat = scrollView.contentSize.width
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            imageView.frame.size.width = imageWidth
            imageView.frame.size.height = imageHeight
            //imageView.center = scrollView.center
            imageView.frame.origin.y = yPosition
            scrollView.addSubview(imageView)
            
            //imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
            //imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0).isActive = true
            //imageView.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 16.0).isActive = true
            
            //let spacer:CGFloat = 20
            //yPosition += imageHeight + spacer
            //scrollViewHeight += imageHeight + spacer
            //scrollView.contentSize = CGSize(width: scrollViewWidth, height: scrollViewHeight)
            
            /*
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 273))
            imageView.image = UIImage(named: imageName)
            
            //imageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
            //imageView.heightAnchor.constraint(equalToConstant: 546).isActive = true
            scrollView.addSubview(imageView)
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0).isActive = true
            imageView.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 600.0).isActive = true
            */
        }
        */
        return cell
    }
    
    func isPageViewItem(_ subview: UIView) -> Bool {
        return subview.tag == 1000
    }
    
    func clearPagerViewCell(_ cell: FSPagerViewCell) {
        let contentView = cell.contentView
        for subview in contentView.subviews {
            if isPageViewItem(subview) {
                subview.removeFromSuperview()
            }
        }
    }
    
    func createScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 1000
        return view
    }
    
    func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "PatrickHand-Regular", size: 27.0)
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = 1000
        return label
    }
    
    func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "PatrickHand-Regular", size: 22.0)
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = 1000
        return label
    }
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.pageData.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
            
            self.pageControl.setStrokeColor(nil, for: .normal)
            self.pageControl.setStrokeColor(nil, for: .selected)
            self.pageControl.setFillColor(nil, for: .normal)
            self.pageControl.setFillColor(nil, for: .selected)
            self.pageControl.setImage(nil, for: .normal)
            self.pageControl.setImage(nil, for: .selected)
            self.pageControl.setPath(nil, for: .normal)
            self.pageControl.setPath(nil, for: .selected)
        }
    }

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    // MARK:- FSPagerViewDelegate
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }

}
