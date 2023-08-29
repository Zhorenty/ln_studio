# Checks two given strings for equality.
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)

get:
	flutter pub get

analyze:
	flutter analyze

format:
	dart format lib --set-exit-if-changed

runner:
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs

	cd packages/database && flutter pub get && dart run build_runner build --delete-conflicting-outputs



clean:
	flutter clean

	cd packages/auth_client && flutter clean

	cd packages/rest_client && flutter clean