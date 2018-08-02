// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

	internal enum Game {

		internal enum Answer {
			/// Select
			internal static let select = L10n.tr("Localizable", "game.answer.select")
		}
	}

	internal enum Welcome {
		/// Start
		internal static let start = L10n.tr("Localizable", "welcome.start")
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
