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
		/// Use Wild Card
		internal static let useWildCard = L10n.tr("Localizable", "game.use_wild_card")

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

		internal enum Messages {
			/// Right Answer, +%d points!
			internal static func rightAnswer(_ p1: Int) -> String {
				return L10n.tr("Localizable", "game.messages.right_answer", p1)
			}
			/// Wrong Answer
			internal static let wrongAnswer = L10n.tr("Localizable", "game.messages.wrong_answer")
		}

		internal enum QuitAlert {
			/// Quit Game?
			internal static let title = L10n.tr("Localizable", "game.quit_alert.title")

			internal enum Options {
				/// Quit
				internal static let quit = L10n.tr("Localizable", "game.quit_alert.options.quit")
				/// Stay
				internal static let stay = L10n.tr("Localizable", "game.quit_alert.options.stay")
			}
		}
	}

	internal enum Scoreboard {
		/// Scoreboard
		internal static let title = L10n.tr("Localizable", "scoreboard.title")

		internal enum Cell {
			/// %d Points
			internal static func totalPoints(_ p1: Int) -> String {
				return L10n.tr("Localizable", "scoreboard.cell.total_points", p1)
			}
		}
	}

	internal enum Welcome {
		/// Scoreboard
		internal static let scoreboard = L10n.tr("Localizable", "welcome.scoreboard")
		/// Start Game!
		internal static let startGame = L10n.tr("Localizable", "welcome.start_game")
		/// View on Github
		internal static let viewOnGithub = L10n.tr("Localizable", "welcome.view_on_github")

		internal enum LogoutAlert {
			/// You will not be able to use the app until you login again
			internal static let message = L10n.tr("Localizable", "welcome.logout_alert.message")
			/// Logout?
			internal static let title = L10n.tr("Localizable", "welcome.logout_alert.title")

			internal enum Options {
				/// Cancel
				internal static let cancel = L10n.tr("Localizable", "welcome.logout_alert.options.cancel")
				/// Logout
				internal static let logout = L10n.tr("Localizable", "welcome.logout_alert.options.logout")
			}
		}
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
