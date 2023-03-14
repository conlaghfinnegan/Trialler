//
//  DetailsView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 22/02/2023.
//

import SwiftUI
import Combine

struct DetailsView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @FocusState var focusedField: JourneyStage?
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                IntroTextView()
                    .padding([.leading, .trailing], 15)
                ZStack {
                    switch viewModel.journeyStage {
                    case .forename:
                        ForenameTextEntryView(focusedField: _focusedField)
                            .padding()
                            .focused($focusedField, equals: .forename)
                    case .surname:
                        SurnameTextEntryView(focusedField: _focusedField)
                            .padding()
                            .focused($focusedField, equals: .surname)
                    case .email:
                        EmailTextEntryView(focusedField: _focusedField)
                            .padding()
                            .focused($focusedField, equals: .email)
                    }
                }
                .onAppear {
                    focusedField = .forename
                }
                .animation(.easeInOut, value: viewModel.journeyStage)
                Spacer()
                ContinueButtonView().opacity(0)
            }
        }
    }
    
    private struct ForenameTextEntryView: View {
        
        @FocusState var focusedField: JourneyStage?
        
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            UserTextField(focusedField: _focusedField,
                          text: $viewModel.forename) {
                Text(Strings.detailsForenamePlaceholder.rawValue)
                    .foregroundColor(Colors.text.color.opacity(0.75))
                    .font(Fonts.bold.font(FontSize.extraLargeTitle.rawValue))
            }
                          .keyboardType(.namePhonePad)
        }
    }
    
    private struct SurnameTextEntryView: View {
        
        @FocusState var focusedField: JourneyStage?
        
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            UserTextField(focusedField: _focusedField,
                          text: $viewModel.surname) {
                Text(Strings.detailsSurnamePlaceholder.rawValue)
                    .foregroundColor(Colors.text.color.opacity(0.75))
                    .font(Fonts.bold.font(FontSize.extraLargeTitle.rawValue))
            }
                          .keyboardType(.namePhonePad)
        }
    }
    
    private struct EmailTextEntryView: View {
        
        @FocusState var focusedField: JourneyStage?
        
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            UserTextField(focusedField: _focusedField,
                          text: $viewModel.emailAddress) {
                Text(Strings.detailsEmailPlaceholder.rawValue)
                    .foregroundColor(Colors.text.color.opacity(0.75))
                    .font(Fonts.bold.font(FontSize.extraLargeTitle.rawValue))
            }
                          .keyboardType(.emailAddress)
        }
    }
    
    fileprivate struct UserTextField<Prompt>: View where Prompt : View {
        
        @FocusState var focusedField: JourneyStage?
        @EnvironmentObject var viewModel: ViewModel
        @Binding var text: String
        @ViewBuilder let prompt: () -> Prompt
        
        var body: some View {
            HStack {
                TextField(String(), text: $text)
                    .placeholder(isShowing: text.isEmpty, placeholder: prompt)
                    .foregroundColor(Colors.text.color)
                    .font(Fonts.bold.font(FontSize.extraLargeTitle.rawValue))
                Image(systemName: Images.detailsTextFieldContinue.rawValue)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Colors.text.color)
                    .padding([.trailing])
                    .opacity(text.isEmpty ? 0 : 1)
                    .animation(.easeInOut, value: text)
                    .onTapGesture {
                        nextButtonTapped()
                    }
            }
        }
        
        private func nextButtonTapped() {
            if viewModel.journeyStage == .email {
                viewModel.commitUserDetails()
            } else {
                viewModel.progressJourneyStage()
                focusedField = viewModel.journeyStage
                UIImpactFeedbackGenerator().impactOccurred()
            }
        }
        
    }
    
    private struct ContinueButtonView: View {
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .foregroundColor(Colors.text.color)
                    .frame(height: 50)
                    .padding()
                HStack {
                    Text(Strings.detailsCtaNext.string)
                        .font(Fonts.bold.font(FontSize.subtitle.rawValue))
                        .foregroundColor(Colors.background.color)
                }
            }
        }
    }
    
    private struct IntroTextView: View {
        
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            VStack(spacing: 8) {
                HStack {
                    Text(Strings.detailsTitle.string)
                        .foregroundColor(Colors.text.color)
                        .font(Fonts.bold.font(FontSize.title.rawValue))
                        .padding([.top], 30)
                    Spacer()
                }
                HStack {
                    Text(viewModel.journeyStage.detailsBodyString)
                        .foregroundColor(Colors.text.color)
                        .font(Fonts.regular.font(FontSize.subtitle.rawValue))
                        .animation(.easeInOut)
                    Spacer()
                }
            }
        }
    }
}

private struct BackgroundView: View {
    var body: some View {
        Colors.background.color
            .ignoresSafeArea()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView().environmentObject(DetailsView.ViewModel(rootView: RootView()))
    }
}
