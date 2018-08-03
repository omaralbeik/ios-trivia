// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

	internal enum Api {

		internal enum Errors {
			/// Unknown Server Error
			internal static let serverError = L10n.tr("Localizable", "api.errors.server_error")
		}
	}

	internal enum Auth {
		/// Email Address
		internal static let emailAddress = L10n.tr("Localizable", "auth.email_address")
		/// Password
		internal static let password = L10n.tr("Localizable", "auth.password")

		internal enum Action {
			/// LOGIN
			internal static let login = L10n.tr("Localizable", "auth.action.login")
			/// REGISTER
			internal static let register = L10n.tr("Localizable", "auth.action.register")
		}

		internal enum Mode {
			/// Login
			internal static let login = L10n.tr("Localizable", "auth.mode.login")
			/// Register
			internal static let register = L10n.tr("Localizable", "auth.mode.register")
		}
	}

	internal enum Game {

		internal enum Answer {
			/// Select
			internal static let select = L10n.tr("Localizable", "game.answer.select")
		}

		internal enum Header {
			/// %d/%d
			internal static func availableWildCards(_ p1: Int, _ p2: Int) -> String {
				return L10n.tr("Localizable", "game.header.available_wild_cards", p1, p2)
			}
			/// %d/%d
			internal static func currentQuestion(_ p1: Int, _ p2: Int) -> String {
				return L10n.tr("Localizable", "game.header.current_question", p1, p2)
			}

			internal enum Titles {
				/// Available Wild Cards
				internal static let availableWildCards = L10n.tr("Localizable", "game.header.titles.available_wild_cards")
				/// Current Question
				internal static let currentQuestion = L10n.tr("Localizable", "game.header.titles.current_question")
			}
		}
	}

	internal enum Welcome {
		/// Scoreboard
		internal static let scoreboard = L10n.tr("Localizable", "welcome.scoreboard")
		/// Start Game!
		internal static let startGame = L10n.tr("Localizable", "welcome.start_game")
		/// Lorem ipsum dolor sit amet, consectetur adipiscing elit.
		internal static let title = L10n.tr("Localizable", "welcome.title")
	}
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
	private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
		let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
		return String(format: format, locale: Locale.current, arguments: args)
	}
}

private final class BundleToken {}
